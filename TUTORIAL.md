# LUMEN OCR v3.1 — Tutorial de uso

> Convierte fotos y PDF en texto editable, **sin internet** y sin que tus archivos salgan del equipo.

---

## Índice

1. [Qué es LUMEN OCR](#1-qué-es-lumen-ocr)
2. [Requisitos](#2-requisitos)
3. [Instalación (primera vez)](#3-instalación-primera-vez)
4. [Conoce la pantalla](#4-conoce-la-pantalla)
5. [Extraer texto paso a paso](#5-extraer-texto-paso-a-paso)
6. [Ajustes de reconocimiento](#6-ajustes-de-reconocimiento)
7. [La cola de trabajo](#7-la-cola-de-trabajo)
8. [Editar el documento](#8-editar-el-documento)
9. [Guardar, exportar y compartir](#9-guardar-exportar-y-compartir)
10. [Idiomas y modo sin internet](#10-idiomas-y-modo-sin-internet)
11. [Atajos de teclado](#11-atajos-de-teclado)
12. [Consejos para mejores resultados](#12-consejos-para-mejores-resultados)
13. [Solución de problemas](#13-solución-de-problemas)
14. [Distribuir la app a clientes o publicarla en la web](#14-distribuir-la-app-a-clientes-o-publicarla-en-la-web)
15. [Preguntas frecuentes](#15-preguntas-frecuentes)

---

## 1. Qué es LUMEN OCR

LUMEN OCR lee el texto que aparece en **fotos, capturas de pantalla y documentos PDF** y lo convierte en texto que puedes copiar, corregir y guardar.

**Puntos fuertes:**

- Funciona **sin internet** (español e inglés incluidos).
- **Privado:** nada se sube a servidores; todo se procesa en tu PC.
- Lee **PDF con texto** al instante y con exactitud total, y PDF **escaneados** mediante OCR.
- Procesa **muchos archivos a la vez** en una cola.
- Incluye **editor de texto**, buscar y reemplazar, y herramientas de limpieza.
- **Autoguardado:** si se va la corriente, recuperas tu trabajo.
- Exporta a **TXT, Word, HTML y PDF**.

---

## 2. Requisitos

| Elemento | Necesario |
|---|---|
| Sistema | Windows 10 u 11 |
| Navegador | Google Chrome o Microsoft Edge (Edge ya viene con Windows) |
| Internet | Solo **una vez**, la primera vez que abres la app (para descargar el motor OCR, ~7 MB) |
| Permisos | No necesita instalar nada ni ser administrador |

---

## 3. Instalación (primera vez)

### Paso 1 — Descomprimir

Haz clic derecho sobre `LUMEN-OCR-v3.1-offline.zip` → **Extraer todo…** y elige una carpeta fija (por ejemplo `Documentos\LUMEN-OCR`).

> ⚠️ No abras la app desde dentro del ZIP sin descomprimir: no funcionará.

La carpeta contiene:

```
LUMEN-OCR/
├── Abrir LUMEN OCR.bat   ← el que debes abrir
├── index.html            ← la app (no abrir directamente)
├── servidor.ps1          ← servidor local (lo usa el .bat)
├── sw.js                 ← copia sin conexión
├── manifest.webmanifest
├── LEEME.txt
├── TUTORIAL.md           ← este documento
└── lib/                  ← motor, idiomas, lector PDF, fuentes
```

### Paso 2 — Abrir la app

Haz doble clic en **`Abrir LUMEN OCR.bat`**.

Ocurren dos cosas:

1. Se abre **LUMEN OCR en su propia ventana**.
2. Aparece una **ventanita minimizada** en la barra de tareas llamada *"LUMEN OCR - servidor local"*. **Déjala abierta** mientras trabajas; ciérrala cuando termines.

> Si Windows muestra un aviso de seguridad (SmartScreen), pulsa **Más información → Ejecutar de todas formas**. Es normal en archivos .bat descargados.

### Paso 3 — Instalación automática del motor (solo la primera vez)

Con internet (o tu VPN) activo, la app:

1. Muestra el aviso **"Instalando el motor OCR (unos 7 MB)…"**.
2. Lo descarga y lo guarda dentro de `lib/tesseract`.
3. Avisa: **"Motor OCR instalado: ya funciona sin internet"**.

Cuando arriba veas **"Motor listo"** y **"· listo offline"**, ya no necesitas internet nunca más.

> 💡 Si no tienes internet en ese momento, la app te lo indica. Conéctate cuando puedas y pulsa **Reintentar** junto al estado del motor.

---

## 4. Conoce la pantalla

```
┌──────────────────────────────────────────────────────────────────┐
│ LUMEN OCR     [● Motor listo]        [● En línea · listo offline] ☀ ? │  ← Barra superior
├──────────────────┬───────────────────────────────────────────────┤
│  ZONA DE CARGA   │  Título del documento   Copiar Pegar Descargar… │
│  Subir · Cámara  ├───────────────────────────────────────────────┤
├──────────────────┤  Barra de formato (negrita, listas, buscar…)   │
│  AJUSTES         ├───────────────────────────────────────────────┤
│  Idioma, tipo…   │                                               │
├──────────────────┤          HOJA DEL DOCUMENTO (editable)        │
│  COLA DE TRABAJO │                                               │
│  [miniaturas]    ├───────────────────────────────────────────────┤
│  Procesar        │  palabras · caracteres · confianza · tiempo   │
├──────────────────┴───────────────────────────────────────────────┤
│  REGISTRO  (Todo · Avisos · Errores)                             │
└──────────────────────────────────────────────────────────────────┘
```

### Indicadores de la barra superior

| Indicador | Significado |
|---|---|
| **● Motor en espera / Cargando… / Motor listo** | Estado del motor OCR. En ámbar = trabajando; verde = listo; rojo = error (aparece **Reintentar**). |
| **● En línea / Sin internet** | Si hay conexión. |
| **· listo offline** (verde) | Todo lo necesario está en tu PC: puedes trabajar sin internet. |
| **· falta descargar** (ámbar) | Falta algo por descargar una sola vez (motor o un idioma). |
| ☀ / 🌙 | Cambia entre tema **oscuro** y **claro**. |
| **?** | Ayuda rápida y atajos. |

---

## 5. Extraer texto paso a paso

### Forma rápida (recomendada)

1. **Arrastra** una o varias fotos o PDF **a cualquier parte de la ventana**.
2. Como la opción *Procesar al añadir archivos* está activa, el reconocimiento empieza solo.
3. El texto aparece en la **hoja del documento**, un bloque por archivo o página.
4. Corrige lo que haga falta y pulsa **Descargar**.

### Otras formas de añadir archivos

| Forma | Cómo |
|---|---|
| **Subir archivos** | Botón *Subir archivos* o atajo `Ctrl + O`. |
| **Captura de pantalla** | Haz la captura (`Win + Shift + S`) y pulsa `Ctrl + V` dentro de la app. |
| **Cámara** | Botón *Cámara* (útil en portátiles o tablets con cámara). |
| **Pegar desde el portapapeles** | Botón *Pegar* del editor: acepta imágenes y texto. |

### Formatos aceptados

- **Imágenes:** JPG, PNG, WEBP, BMP, GIF, AVIF.
- **PDF:** con texto, escaneados o protegidos con contraseña (te la pedirá).
- **No compatible:** HEIC (fotos de iPhone). Conviértelas antes a JPG.

---

## 6. Ajustes de reconocimiento

Se encuentran en el panel **Ajustes de reconocimiento** (puedes plegarlo). Se recuerdan entre sesiones.

### Idioma del documento

Elige el idioma en que está escrito el texto. La lista tiene dos grupos:

- **Instalados · funcionan sin internet** (marcados con ✓). Por defecto: *Español + Inglés*, *Español* e *Inglés*.
- **Se descargan una sola vez al elegirlos**: muestran su tamaño en MB. Ver [sección 10](#10-idiomas-y-modo-sin-internet).

> 💡 *Español + Inglés* es la mejor opción para documentos mixtos. Si el texto está solo en un idioma, elegir solo ese da resultados un poco más precisos.

### Tipo de página

| Opción | Úsala para |
|---|---|
| **Automático** | La mayoría de casos (recomendado). |
| **Una columna** | Libros, cartas, documentos de texto corrido. |
| **Bloque de texto uniforme** | Párrafos limpios, sin columnas ni tablas. |
| **Texto disperso** | Tickets, carteles, etiquetas, capturas de apps. |
| **Una sola línea** | Recortes con una única línea (un título, una matrícula). |

### Interruptores

| Opción | Qué hace |
|---|---|
| **Mejorar imagen** | Pasa la imagen a gris y ajusta el contraste. Ayuda con fotos oscuras o lavadas. |
| **Usar texto nativo del PDF** | Si el PDF ya trae texto, lo extrae al instante y sin errores (sin OCR). |
| **Procesar al añadir archivos** | Empieza a leer en cuanto añades algo. |
| **Encabezado de origen** | Pone sobre cada bloque el nombre del archivo, la confianza y el tiempo. |

---

## 7. La cola de trabajo

Cada imagen o página de PDF aparece como una tarjeta con miniatura y estado:

| Etiqueta | Significado |
|---|---|
| **En cola** | Esperando turno. |
| **Procesando** | Leyendo ahora (barra de progreso y línea de escaneo). |
| **Listo · 92 %** | Terminado. El porcentaje es la **confianza**: verde ≥ 85 %, ámbar 65–84 %, rojo < 65 %. |
| **✓ exacto** | Texto sacado directamente del PDF (100 % fiable). |
| **Error** | No se pudo leer. Pasa el ratón por encima para ver el motivo. |

### Botones de cada tarjeta

| Botón | Acción |
|---|---|
| Clic en la **miniatura** | Vista previa grande, con *Girar 90°* y *Reprocesar*. |
| **↻ Girar** | Gira la imagen 90° y la vuelve a leer sola (para fotos tomadas de lado). |
| **⟳ Reprocesar** | Vuelve a leerla (útil tras cambiar idioma o tipo de página). |
| **✕ Quitar** | La saca de la cola. |

### Controles generales

- **Procesar / Detener:** inicia la cola o la detiene al terminar el elemento actual.
- **Vaciar:** limpia la cola (el documento no se toca).
- La barra inferior muestra el progreso total (por ejemplo, `5 / 12`).

> 💡 Mientras procesa, la app evita que la pantalla se apague.

---

## 8. Editar el documento

La hoja central es un **editor completo**: haz clic y escribe como en Word.

### Barra de formato

Deshacer/rehacer · fuente · tamaño · **negrita** · *cursiva* · subrayado · tachado · color de texto · resaltado · quitar formato · alineación · listas · sangría.

### Buscar y reemplazar (`Ctrl + F`)

1. Escribe lo que buscas; verás cuántas coincidencias hay.
2. **Siguiente** (o `Intro`) salta a cada una.
3. Escribe el reemplazo y pulsa **Reemplazar todo**.
4. `Aa` distingue mayúsculas de minúsculas.
5. Tras reemplazar aparece **Deshacer** en el aviso.

### Menú «Limpiar texto»

| Herramienta | Para qué sirve |
|---|---|
| **Unir líneas partidas** | El OCR corta las líneas como en el papel; esto las une en párrafos y repara palabras cortadas con guion. |
| **Corregir espacios** | Quita espacios dobles y espacios antes de comas o puntos. |
| **Quitar encabezados de origen** | Borra las líneas de nombre de archivo de cada bloque. |
| **Selección a MAYÚSCULAS / minúsculas / Tipo oración** | Cambia el texto que hayas seleccionado. |

Todas muestran un botón **Deshacer** por si el resultado no te convence.

### Título del documento

Haz clic en *"Documento extraído"* (arriba) y escribe un nombre: se usará al descargar.

---

## 9. Guardar, exportar y compartir

### Autoguardado

El documento se guarda **solo** en el navegador cada pocos segundos (abajo a la derecha verás *"Autoguardado HH:MM"*). Si se va la corriente o cierras la app, al volver a abrirla aparece **"Se recuperó tu documento anterior"** (con opción *Descartar*).

> ⚠️ El autoguardado es una red de seguridad, no un archivo. Descarga siempre tu trabajo final.

### Descargar

| Opción | Resultado |
|---|---|
| **Descargar** (botón principal) o `Ctrl + S` | Archivo **.txt** (texto plano, compatible con todo). |
| Flecha ▾ → **Word** | Archivo **.doc** que se abre en Word o LibreOffice, con formato. |
| Flecha ▾ → **Página web** | Archivo **.html**. |
| Flecha ▾ → **Imprimir / Guardar PDF** | Abre la impresión; elige **"Guardar como PDF"** como impresora. |

Los archivos se nombran con el título y la fecha, por ejemplo `Contrato-alquiler_20261031-1530.txt`.

### Copiar y compartir

- **Copiar:** copia todo el texto al portapapeles para pegarlo en WhatsApp, correo, etc.
- **Compartir:** abre el menú de compartir de Windows (si no está disponible, copia el texto).

### Limpiar

**Limpiar** (botón rojo) borra el documento, la cola y el registro tras pedir confirmación. El motor sigue cargado.

---

## 10. Idiomas y modo sin internet

### Qué funciona sin internet

| Elemento | Estado |
|---|---|
| Español e Inglés | ✅ Incluidos |
| Lector de PDF | ✅ Incluido |
| Interfaz, fuentes e iconos | ✅ Incluidos |
| Motor OCR | ✅ Tras la primera apertura con internet |
| Otros idiomas | ✅ Tras elegirlos una vez con internet |

### Añadir un idioma nuevo

1. En **Idioma del documento**, elige uno del grupo *"Se descargan una sola vez"* (por ejemplo *Portugués · 1.3 MB*).
2. Debajo aparece **"⬇ Se descargará una sola vez"**.
3. La app avisa **"Descargando el idioma Portugués…"** y lo guarda en `lib/lang`.
4. Aviso final: **"Portugués instalado: ya funciona sin internet"**. Desde ese momento aparece con ✓ en el grupo de instalados.

**Idiomas disponibles (24):** español, inglés, portugués, francés, italiano, alemán, catalán, gallego, euskera, neerlandés, polaco, rumano, turco, ruso, ucraniano, griego, latín, árabe, hebreo, hindi, japonés, coreano, chino simplificado y chino tradicional.

### Avisos automáticos

La app te informa en pantalla (y en el **Registro**) de todo cambio:

- Descargas del motor o de idiomas, y su resultado.
- Pérdida o recuperación de la conexión, indicando si puedes seguir trabajando.
- Versión nueva disponible (botón **Actualizar**).
- Activación de la copia sin conexión.

---

## 11. Atajos de teclado

| Atajo | Acción |
|---|---|
| `Ctrl + Intro` | Procesar la cola |
| `Ctrl + O` | Abrir archivos |
| `Ctrl + V` | Pegar una captura para leerla |
| `Ctrl + S` | Descargar como .txt |
| `Ctrl + F` | Buscar y reemplazar (con el cursor en el documento) |
| `Ctrl + Z` / `Ctrl + Y` | Deshacer / rehacer |
| `Ctrl + B` / `I` / `U` | Negrita / cursiva / subrayado |
| `Esc` | Cerrar menús, ventanas o la barra de búsqueda |

---

## 12. Consejos para mejores resultados

- 📸 **Buena luz y sin sombras.** La luz natural lateral es ideal; evita el flash directo sobre papel brillante.
- 📐 **Foto recta y de frente**, con el documento ocupando casi todo el encuadre.
- 🔍 **Resolución suficiente:** al menos 1200 px en el lado corto. La app avisa si la imagen es pequeña.
- 🔄 **Foto de lado:** usa **↻ Girar** en la cola.
- 🧾 **Tickets y carteles:** tipo de página *Texto disperso*.
- 📖 **Libros:** tipo de página *Una columna*, y después *Limpiar texto → Unir líneas partidas*.
- 📄 **PDF digitales:** deja activado *Usar texto nativo del PDF*: es instantáneo y exacto.
- 🌑 **Fotos oscuras o de fotocopia:** deja activado *Mejorar imagen*.
- ⚠️ **Confianza baja (rojo):** prueba otro tipo de página, gira la imagen o haz una foto más nítida y pulsa **Reprocesar**.

---

## 13. Solución de problemas

| Problema | Solución |
|---|---|
| Aparece el aviso **"Abre la app con «Abrir LUMEN OCR.bat»"** | Abriste `index.html` directamente. Ciérralo y usa el `.bat`. |
| **"Motor no disponible"** la primera vez | Falta internet para instalar el motor. Conecta la VPN y pulsa **Reintentar**. |
| **"no hay conexión con el servidor local"** | Cerraste la ventanita del servidor. Vuelve a abrir `Abrir LUMEN OCR.bat`. |
| El `.bat` se abre y se cierra sin hacer nada | Comprueba que descomprimiste el ZIP. Si persiste, haz clic derecho en `servidor.ps1` → **Ejecutar con PowerShell** para ver el mensaje de error. |
| **"Todos los puertos ocupados"** | Cierra otras ventanas de LUMEN OCR o reinicia el PC. |
| Un idioma no se descarga | Comprueba la conexión o la VPN y vuelve a elegirlo en la lista. |
| **PDF protegido** | Escribe la contraseña cuando te la pida. Si la cancelas, el PDF no se abre. |
| **Foto HEIC de iPhone** | Conviértela a JPG (en el iPhone: *Ajustes → Cámara → Formatos → Más compatible*). |
| El texto sale con muchos errores | Revisa la [sección 12](#12-consejos-para-mejores-resultados). |
| La app va lenta con PDF grandes | Es normal en PDF escaneados de muchas páginas: cada página se lee por OCR. Puedes **Detener** y seguir luego. |

> 💡 El panel **Registro** (abajo) explica qué ha pasado en cada paso. Usa los filtros *Avisos* y *Errores*, y el botón **copiar** para enviarme el registro si necesitas ayuda.

---

## 14. Distribuir la app a clientes o publicarla en la web

### Entregar a un cliente (sin internet desde el primer día)

1. Abre la app **una vez** en tu PC con internet, para que se instale el motor.
2. (Opcional) Elige los idiomas extra que tu cliente necesite, para que también se descarguen.
3. Cierra la app y la ventanita del servidor.
4. Comprime la carpeta `LUMEN-OCR` completa → ya tiene **todo incluido**.
5. Tu cliente solo descomprime y abre `Abrir LUMEN OCR.bat`. **No necesitará internet.**

### Publicarla en tu web (GitHub Pages)

1. Sube **toda la carpeta** tal cual a un repositorio, igual que tus otras herramientas de Herramix.
2. Activa GitHub Pages.
3. En la web **no se usa el .bat**: el visitante abre la dirección, y la app se guarda sola en su navegador para funcionar después sin conexión (puede *instalarla* desde el icono de la barra de direcciones).

> Si subes la carpeta con el motor ya instalado en `lib/tesseract`, los visitantes no tendrán que descargarlo de otras webs.

---

## 15. Preguntas frecuentes

**¿Mis documentos se suben a algún sitio?**
No. Todo el reconocimiento ocurre en tu PC. Internet solo se usa para descargar, una vez, el motor y los idiomas.

**¿Puedo cerrar la ventanita del servidor?**
Sí, cuando termines de trabajar. Mientras usas la app, déjala abierta (minimizada). Si la cierras, la app sigue abriendo desde la copia del navegador, pero no podrá descargar idiomas nuevos.

**¿Dónde se guardan los idiomas que descargo?**
En la carpeta `lib/lang` de la app. Así se quedan contigo aunque copies la carpeta a otro PC.

**¿Cuánto ocupa la app?**
Unos 11 MB descomprimida, y unos 18 MB con el motor instalado. Cada idioma extra ocupa entre 0,6 y 3 MB.

**¿Funciona en el móvil?**
Publicada en la web, sí abre en el navegador del móvil (con el botón *Cámara* para fotografiar documentos). El `.bat` es solo para Windows.

**¿Puede traducir el texto?**
Esta versión reconoce texto en 24 idiomas, pero no lo traduce. La traducción sin internet sería una función aparte.

---

*LUMEN OCR v3.1 · Reconocimiento con Tesseract OCR y PDF.js (licencia Apache 2.0) · Fuentes Manrope, Fraunces y JetBrains Mono (licencia SIL OFL 1.1).*
*Soporte y licencias: WhatsApp 5355081288.*
