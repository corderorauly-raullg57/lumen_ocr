# ═══════════════════════════════════════════════════════════════════
#  LUMEN OCR — servidor local
#  Sirve la app en http://127.0.0.1:8765 para que funcione SIN internet
#  y descarga automáticamente (una sola vez) lo que falte: el motor OCR
#  o un idioma nuevo. No necesita instalar nada ni permisos de administrador.
#  Deja esta ventana abierta (puede estar minimizada) mientras uses la app.
# ═══════════════════════════════════════════════════════════════════
$ErrorActionPreference = 'Stop'
try { $Host.UI.RawUI.WindowTitle = 'LUMEN OCR - servidor local (no cerrar mientras trabajas)' } catch {}
try { [Console]::OutputEncoding = [Text.Encoding]::UTF8 } catch {}
try { [Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12 } catch {}

$VERSION  = '3.1'
$ROOT     = Split-Path -Parent $MyInvocation.MyCommand.Path
$SEP      = [IO.Path]::DirectorySeparatorChar
$ROOTFULL = [IO.Path]::GetFullPath($ROOT).TrimEnd($SEP) + $SEP
$PUERTOS  = 8765..8774
$TESS     = '5.1.1'
$CORE     = '5.1.1'
$DIR_MOTOR  = Join-Path (Join-Path $ROOT 'lib') 'tesseract'
$DIR_IDIOMA = Join-Path (Join-Path $ROOT 'lib') 'lang'

# Archivos del motor OCR. El principal (tesseract.min.js) va al final:
# solo cuando existe se considera el motor completo.
$MOTOR = @(
  @{ f = 'worker.min.js'; u = @("https://cdn.jsdelivr.net/npm/tesseract.js@$TESS/dist/worker.min.js", "https://unpkg.com/tesseract.js@$TESS/dist/worker.min.js") },
  @{ f = 'tesseract-core-simd-lstm.wasm.js'; u = @("https://cdn.jsdelivr.net/npm/tesseract.js-core@$CORE/tesseract-core-simd-lstm.wasm.js", "https://unpkg.com/tesseract.js-core@$CORE/tesseract-core-simd-lstm.wasm.js") },
  @{ f = 'tesseract-core-lstm.wasm.js'; u = @("https://cdn.jsdelivr.net/npm/tesseract.js-core@$CORE/tesseract-core-lstm.wasm.js", "https://unpkg.com/tesseract.js-core@$CORE/tesseract-core-lstm.wasm.js") },
  @{ f = 'tesseract.min.js'; u = @("https://cdn.jsdelivr.net/npm/tesseract.js@$TESS/dist/tesseract.min.js", "https://unpkg.com/tesseract.js@$TESS/dist/tesseract.min.js") }
)

$MIME = @{
  '.html' = 'text/html; charset=utf-8'; '.htm' = 'text/html; charset=utf-8'
  '.js' = 'application/javascript; charset=utf-8'; '.mjs' = 'application/javascript; charset=utf-8'
  '.css' = 'text/css; charset=utf-8'; '.json' = 'application/json; charset=utf-8'
  '.webmanifest' = 'application/manifest+json; charset=utf-8'; '.txt' = 'text/plain; charset=utf-8'
  '.svg' = 'image/svg+xml'; '.png' = 'image/png'; '.jpg' = 'image/jpeg'; '.jpeg' = 'image/jpeg'; '.ico' = 'image/x-icon'; '.webp' = 'image/webp'
  '.wasm' = 'application/wasm'; '.woff' = 'font/woff'; '.woff2' = 'font/woff2'; '.ttf' = 'font/ttf'
  '.pdf' = 'application/pdf'; '.gz' = 'application/octet-stream'; '.bcmap' = 'application/octet-stream'; '.pfb' = 'application/octet-stream'
}

function Escribir([string]$texto, [string]$color = 'Gray') {
  Write-Host ("[{0}] {1}" -f (Get-Date -Format 'HH:mm:ss'), $texto) -ForegroundColor $color
}

function Motor-Completo {
  foreach ($m in $MOTOR) {
    $p = Join-Path $DIR_MOTOR $m.f
    if (-not (Test-Path -LiteralPath $p)) { return $false }
    if ((Get-Item -LiteralPath $p).Length -lt 10000) { return $false }
  }
  return $true
}

function Idiomas-Instalados {
  if (-not (Test-Path -LiteralPath $DIR_IDIOMA)) { return @() }
  return @(Get-ChildItem -LiteralPath $DIR_IDIOMA -Filter '*.traineddata.gz' | Where-Object { $_.Length -gt 10000 } |
           ForEach-Object { $_.Name -replace '\.traineddata\.gz$', '' })
}

# Descarga probando varias fuentes; valida el archivo y lo coloca de forma atómica.
function Descargar([string[]]$urls, [string]$destino, [int]$primerByte = -1) {
  $tmp = "$destino.descargando"
  $dir = Split-Path -Parent $destino
  if (-not (Test-Path -LiteralPath $dir)) { New-Item -ItemType Directory -Path $dir -Force | Out-Null }
  foreach ($u in $urls) {
    try {
      Escribir "   descargando $u" 'DarkGray'
      $wc = New-Object Net.WebClient
      $wc.Headers.Add('User-Agent', "LUMEN-OCR/$VERSION")
      $wc.DownloadFile($u, $tmp)
      $wc.Dispose()
      $len = (Get-Item -LiteralPath $tmp).Length
      if ($len -lt 10000) { throw "archivo demasiado pequeño ($len bytes)" }
      $fs = [IO.File]::OpenRead($tmp); $b = $fs.ReadByte(); $fs.Close()
      if ($b -eq 60) { throw 'el servidor devolvió una página en lugar del archivo' }
      if ($primerByte -ge 0 -and $b -ne $primerByte) { throw 'el archivo no tiene el formato esperado' }
      if (Test-Path -LiteralPath $destino) { Remove-Item -LiteralPath $destino -Force }
      Move-Item -LiteralPath $tmp -Destination $destino -Force
      Escribir ("   listo ({0:N1} MB)" -f ($len / 1MB)) 'Green'
      return $len
    } catch {
      Escribir "   fallo: $($_.Exception.Message)" 'Yellow'
      if (Test-Path -LiteralPath $tmp) { Remove-Item -LiteralPath $tmp -Force -ErrorAction SilentlyContinue }
    }
  }
  return 0
}

function Instalar-Motor {
  Escribir 'Instalando el motor OCR en la carpeta de la app (solo esta vez)...' 'Cyan'
  foreach ($m in $MOTOR) {
    $dest = Join-Path $DIR_MOTOR $m.f
    if ((Test-Path -LiteralPath $dest) -and ((Get-Item -LiteralPath $dest).Length -ge 10000)) { continue }
    $n = Descargar $m.u $dest
    if ($n -le 0) { return @{ ok = $false; error = "no se pudo descargar $($m.f). Revisa la conexión o la VPN" } }
  }
  Escribir 'Motor OCR instalado. Desde ahora funciona sin internet.' 'Green'
  return @{ ok = $true; motor = $true }
}

function Instalar-Idioma([string]$codigo) {
  if ($codigo -notmatch '^[a-z]{3}(_[a-z]{3,4})?$') { return @{ ok = $false; error = 'código de idioma no válido' } }
  $dest = Join-Path $DIR_IDIOMA "$codigo.traineddata.gz"
  if ((Test-Path -LiteralPath $dest) -and ((Get-Item -LiteralPath $dest).Length -gt 10000)) { return @{ ok = $true; codigo = $codigo; ya = $true } }
  Escribir "Descargando el idioma '$codigo' (solo esta vez)..." 'Cyan'
  $urls = @(
    "https://cdn.jsdelivr.net/npm/@tesseract.js-data/$codigo/4.0.0_best_int/$codigo.traineddata.gz",
    "https://unpkg.com/@tesseract.js-data/$codigo/4.0.0_best_int/$codigo.traineddata.gz",
    "https://raw.githubusercontent.com/naptha/tessdata/gh-pages/4.0.0_best_int/$codigo.traineddata.gz"
  )
  $n = Descargar $urls $dest 31   # 31 = 0x1F, inicio de un archivo .gz
  if ($n -le 0) { return @{ ok = $false; error = 'no se pudo descargar. Revisa la conexión o la VPN.' } }
  return @{ ok = $true; codigo = $codigo; bytes = $n }
}

# ── Servidor HTTP mínimo sobre TCP (solo 127.0.0.1, una conexión por petición) ──
$ESTADOS = @{ 200 = 'OK'; 400 = 'Bad Request'; 403 = 'Forbidden'; 404 = 'Not Found'; 405 = 'Method Not Allowed'; 500 = 'Internal Server Error' }

function Enviar($pet, [int]$codigo, [byte[]]$datos, [string]$tipo, [string]$cache = 'no-cache') {
  $cab = "HTTP/1.1 $codigo $($ESTADOS[$codigo])`r`n" +
         "Content-Type: $tipo`r`n" +
         "Content-Length: $($datos.Length)`r`n" +
         "Cache-Control: $cache`r`n" +
         "X-Content-Type-Options: nosniff`r`n" +
         "Connection: close`r`n`r`n"
  $b = [Text.Encoding]::ASCII.GetBytes($cab)
  $pet.ns.Write($b, 0, $b.Length)
  if ($pet.metodo -ne 'HEAD' -and $datos.Length -gt 0) { $pet.ns.Write($datos, 0, $datos.Length) }
  $pet.ns.Flush()
  if ($env:LUMEN_DEBUG) { Escribir "   -> $codigo ($($datos.Length) bytes)" 'DarkGray' }
}
function Enviar-Json($pet, $obj) {
  $json = $obj | ConvertTo-Json -Compress -Depth 5
  Enviar $pet 200 ([Text.Encoding]::UTF8.GetBytes($json)) 'application/json; charset=utf-8' 'no-store'
}
function Enviar-Texto($pet, [int]$codigo, [string]$texto) {
  Enviar $pet $codigo ([Text.Encoding]::UTF8.GetBytes($texto)) 'text/plain; charset=utf-8' 'no-store'
}

# Lee la cabecera de la petición (máx. 64 KB) y devuelve método, ruta, consulta y host.
function Leer-Peticion($cliente) {
  $cliente.ReceiveTimeout = 5000
  $cliente.SendTimeout = 60000
  $ns = $cliente.GetStream()
  $buf = New-Object byte[] 8192
  $ms = New-Object IO.MemoryStream
  $texto = ''
  while ($true) {
    $n = $ns.Read($buf, 0, $buf.Length)
    if ($n -le 0) { break }
    $ms.Write($buf, 0, $n)
    $texto = [Text.Encoding]::ASCII.GetString($ms.ToArray())
    if ($texto.Contains("`r`n`r`n") -or $ms.Length -gt 65536) { break }
  }
  $lineas = $texto -split "`r`n"
  $partes = $lineas[0] -split ' '
  if ($partes.Count -lt 3) { return $null }
  $hostCab = ''
  foreach ($l in $lineas) { if ($l -match '^(?i)host:\s*(.+)$') { $hostCab = $Matches[1].Trim() } }
  $objetivo = $partes[1]
  $q = ''
  $i = $objetivo.IndexOf('?')
  if ($i -ge 0) { $q = $objetivo.Substring($i + 1); $objetivo = $objetivo.Substring(0, $i) }
  $consulta = @{}
  foreach ($par in ($q -split '&')) {
    if (-not $par) { continue }
    $kv = $par -split '=', 2
    $consulta[[Uri]::UnescapeDataString($kv[0])] = if ($kv.Count -gt 1) { [Uri]::UnescapeDataString($kv[1].Replace('+', ' ')) } else { '' }
  }
  return @{ ns = $ns; metodo = $partes[0].ToUpperInvariant(); ruta = [Uri]::UnescapeDataString($objetivo); consulta = $consulta; host = $hostCab }
}

function Atender($pet) {
  $ruta = $pet.ruta
  if ($env:LUMEN_DEBUG) { Escribir "$($pet.metodo) $ruta" 'DarkGray' }

  # Solo peticiones dirigidas a este equipo (protege contra páginas web ajenas)
  if ($pet.host -notmatch "^(localhost|127\.0\.0\.1)(:$PUERTO)?$") { Enviar-Texto $pet 403 'Prohibido'; return }

  if ($ruta.StartsWith('/__lumen/')) {
    switch ($ruta) {
      '/__lumen/estado' { Enviar-Json $pet @{ lumen = $true; version = $VERSION; motor = (Motor-Completo); idiomas = @(Idiomas-Instalados) }; return }
      '/__lumen/motor'  { if (Motor-Completo) { Enviar-Json $pet @{ ok = $true; motor = $true } } else { Enviar-Json $pet (Instalar-Motor) }; return }
      '/__lumen/idioma' { Enviar-Json $pet (Instalar-Idioma ([string]$pet.consulta['codigo'])); return }
      default { Enviar-Texto $pet 404 'No encontrado'; return }
    }
  }

  if ($pet.metodo -ne 'GET' -and $pet.metodo -ne 'HEAD') { Enviar-Texto $pet 405 'Método no permitido'; return }
  if ($ruta.EndsWith('/')) { $ruta += 'index.html' }
  $rel = $ruta.TrimStart('/').Replace('/', $SEP)
  $completo = [IO.Path]::GetFullPath([IO.Path]::Combine($ROOT, $rel))
  if (-not $completo.StartsWith($ROOTFULL, [StringComparison]::OrdinalIgnoreCase)) { Enviar-Texto $pet 403 'Prohibido'; return }
  if (-not (Test-Path -LiteralPath $completo -PathType Leaf)) { Enviar-Texto $pet 404 'No encontrado'; return }

  $ext = [IO.Path]::GetExtension($completo).ToLowerInvariant()
  $tipo = $MIME[$ext]; if (-not $tipo) { $tipo = 'application/octet-stream' }
  $cache = 'no-cache'
  if ($ruta.StartsWith('/lib/')) { $cache = 'public, max-age=604800' }
  Enviar $pet 200 ([IO.File]::ReadAllBytes($completo)) $tipo $cache
}

function Abrir-App([int]$puerto) {
  $url = "http://127.0.0.1:$puerto/"
  $chrome = @("$env:ProgramFiles\Google\Chrome\Application\chrome.exe", "${env:ProgramFiles(x86)}\Google\Chrome\Application\chrome.exe", "$env:LocalAppData\Google\Chrome\Application\chrome.exe") |
            Where-Object { $_ -and (Test-Path -LiteralPath $_) } | Select-Object -First 1
  $edge = @("${env:ProgramFiles(x86)}\Microsoft\Edge\Application\msedge.exe", "$env:ProgramFiles\Microsoft\Edge\Application\msedge.exe") |
          Where-Object { $_ -and (Test-Path -LiteralPath $_) } | Select-Object -First 1
  try {
    if ($chrome) { Start-Process -FilePath $chrome -ArgumentList "--app=$url" }
    elseif ($edge) { Start-Process -FilePath $edge -ArgumentList "--app=$url" }
    else { Start-Process $url }
  } catch {
    try { Start-Process $url } catch { Escribir "Abre esta dirección en tu navegador: $url" 'Yellow' }
  }
}

# ── Arranque ─────────────────────────────────────────────────────────
Write-Host ''
Write-Host '  LUMEN OCR · servidor local' -ForegroundColor Yellow
Write-Host '  ─────────────────────────────────────────────' -ForegroundColor DarkGray
Write-Host '  Deja esta ventana abierta mientras uses la app.' -ForegroundColor Gray
Write-Host ''

$tcp = $null; $PUERTO = 0
foreach ($p in $PUERTOS) {
  # ¿Ya hay un LUMEN OCR abierto en este puerto? Entonces solo abrimos la ventana.
  try {
    $r = Invoke-WebRequest -UseBasicParsing -TimeoutSec 2 -Uri "http://127.0.0.1:$p/__lumen/estado"
    if ($r.Content -match '"lumen"') { Escribir "LUMEN OCR ya estaba abierto (puerto $p). Abriendo la ventana..." 'Green'; Abrir-App $p; Start-Sleep -Seconds 2; exit }
  } catch {}
  try {
    $t = New-Object Net.Sockets.TcpListener([Net.IPAddress]::Loopback, $p)
    $t.Start()
    $tcp = $t; $PUERTO = $p; break
  } catch { Escribir "El puerto $p está ocupado, probando otro..." 'DarkYellow' }
}
if (-not $tcp) {
  Escribir 'No se pudo iniciar el servidor local (todos los puertos ocupados).' 'Red'
  Read-Host 'Pulsa Intro para cerrar'
  exit 1
}

$estadoMotor = if (Motor-Completo) { 'instalado' } else { 'se descargará automáticamente la primera vez (unos 7 MB)' }
Escribir "Servidor activo en http://127.0.0.1:$PUERTO/" 'Green'
Escribir "Motor OCR: $estadoMotor" 'Gray'
Escribir ("Idiomas en la carpeta: " + ((Idiomas-Instalados) -join ', ')) 'Gray'
Abrir-App $PUERTO

# Bucle principal: acepta conexiones y atiende solo las que ya enviaron datos,
# así una conexión «vacía» del navegador nunca bloquea a las demás.
$espera = New-Object System.Collections.ArrayList
try {
  while ($true) {
    while ($tcp.Pending()) { [void]$espera.Add(@{ c = $tcp.AcceptTcpClient(); t = [DateTime]::UtcNow }) }
    $trabajo = $false
    foreach ($e in @($espera)) {
      $c = $e.c
      try {
        if ($c.Available -gt 0) {
          $espera.Remove($e)
          $trabajo = $true
          $pet = Leer-Peticion $c
          if ($pet) {
            try { Atender $pet }
            catch {
              Escribir "Error atendiendo $($pet.ruta): $($_.Exception.Message)" 'Yellow'
              try { Enviar-Texto $pet 500 'Error interno' } catch {}
            }
          }
          $c.Close()
        } elseif (([DateTime]::UtcNow - $e.t).TotalSeconds -gt 30 -or ($c.Client.Poll(0, [Net.Sockets.SelectMode]::SelectRead) -and $c.Available -eq 0)) {
          $espera.Remove($e); $c.Close()      # conexión cerrada o inactiva
        }
      } catch {
        $espera.Remove($e); try { $c.Close() } catch {}
      }
    }
    if (-not $trabajo) { Start-Sleep -Milliseconds 10 }
  }
} finally {
  try { $tcp.Stop() } catch {}
}
