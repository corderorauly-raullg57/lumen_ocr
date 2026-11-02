# 📖 LUMEN OCR Studio — Manual de uso completo

> **Versión de la app:** 2.4 · **Motor:** Tesseract OCR + PDF.js (100 % local en tu navegador)
> **Archivo de la app:** `lumen-ocr.html`

---

## 1. ¿Qué es LUMEN OCR?

LUMEN OCR es una aplicación web de **una sola página** que extrae el texto visible dentro de imágenes y documentos escaneados mediante **OCR** (*Reconocimiento Óptico de Caracteres*, por sus siglas en inglés).

### ¿Qué puede procesar?

| Entrada | Ejemplos |
|---|---|
|  Fotos | Capturas de pantalla, fotos de carteles, pizarras, tickets, DNI… |
| 🖼️ Imágenes digitales | JPG, PNG, WEBP, BMP, GIF |
| 📄 PDF escaneados | PDF cuyas páginas son imágenes (sin texto seleccionable) |
| 📋 Pegados | Capturas copiadas con `Ctrl+V` directamente |

### ¿Qué obtienes?

Un **documento editable estilo Word** con el texto extraído, que puedes corregir, formatear, copiar, descargar (`.txt`, `.html`, `.doc`) o compartir.

> 🔒 **Privacidad:** todo el procesamiento ocurre dentro de tu navegador. **Ningún archivo se sube a internet.** Solo se descarga el motor OCR la primera vez.

---

## 2. Requisitos

| Elemento | Detalle |
|---|---|
| Navegador | Chrome, Edge, Firefox, Safari o Opera **actualizados** |
| Conexión | **Solo la primera vez** (descarga el motor OCR y las fuentes). Después queda en caché |
| Instalación | **Ninguna.** No necesita servidor, ni cuentas, ni permisos |
| Hardware recomendado | 4 GB RAM o más para PDF largos |

---

## 3. Instalación y primer arranque

1. Copia **todo** el código de la app.
2. Ábrelo con el **Bloc de notas** (Windows) o **TextEdit** en modo texto plano (Mac).
3. Pega el código.
4. Guarda como `lumen-ocr.html`
   - ⚠️ En Windows: en *Tipo* elige **«Todos los archivos»** para que no quede `lumen-ocr.html.txt`.
5. Haz **doble clic** en el archivo → se abre en tu navegador.
6. Espera unos segundos: el indicador superior dirá **«Motor listo»** en verde. Ya puedes trabajar.

> 💡 **Truco:** arrastra el archivo a la barra de favoritos para tenerlo siempre a mano, o clic derecho → *Enviar a → Escritorio (crear acceso directo)*.

---

## 4. Recorrido por la interfaz

La pantalla se divide en **5 zonas**:

```
┌──────────────────────────────────────────────────────────┐
│ ① BARRA SUPERIOR  (marca, idioma OCR, estado del motor)  │
├───────────────┬──────────────────────────────────────────┤
│ ② ZONA DE     │ ④ EDITOR ESTILO WORD                     │
│    CARGA      │    (título, botones de acción, barra de  │
│               │     formato, hoja de papel, estadísticas)│
│ ③ COLA DE     │                                          │
│    TRABAJO    │                                          │
├───────────────┴──────────────────────────────────────────┤
│ ⑤ REGISTRO DE ACTIVIDAD (consola / log)                  │
└──────────────────────────────────────────────────────────┘
```

### ① Barra superior
- **Logo y versión** de la app.
- **Selector de idioma OCR:** Español + Inglés (por defecto), Español, Inglés, Portugués, Francés, Italiano, Alemán.
- **Indicador del motor** (punto de color):
  - 🟢 Verde = listo · 🟠 Ámbar parpadeante = cargando o reconociendo · 🔴 Rojo = error.
- Recordatorio de atajos: `Ctrl+Intro` procesa, `Ctrl+S` descarga.

### ② Zona de carga
Rectángulo con esquinas ámbar y una **línea de escaneo animada**. Aquí sueltas o eliges archivos.

### ③ Cola de trabajo
Lista de miniaturas de todo lo añadido, con su estado y progreso. Incluye:
- Contador de elementos.
- Botones **Vaciar** y **Procesar / Detener**.
- Casilla **«Procesar automáticamente al añadir»** (activa por defecto).
- Barra de progreso global `hechos / total`.

### ④ Editor
- **Título editable** del documento.
- Botones de acción: **Copiar, Pegar, Descargar ▾, Compartir, Limpiar todo**.
- **Barra de formato** tipo Word (dos filas de herramientas).
- **Hoja blanca** donde aparece el texto extraído, editable.
- **Pie de estadísticas:** palabras, caracteres, elementos procesados, confianza media y tiempo de OCR.

### ⑤ Registro de actividad
Consola oscura tipo terminal que anota **todo** lo que hace la app, con hora y nivel.

---

## 5. Flujo básico en 5 pasos

1. **Añade** una foto o PDF (arrástralo a la zona punteada o pulsa *Subir archivos*).
2. La app lo coloca en la **cola** y, si el auto-proceso está activo, **empieza sola**.
3. Observa el progreso: línea ámbar sobre la miniatura y porcentaje en el indicador del motor.
4. El texto aparece en la **hoja blanca**, encabezado por el nombre del archivo y su % de confianza.
5. **Corrige y exporta**: edita como en Word y usa *Copiar*, *Descargar* o *Compartir*.

---

## 6. Las 4 formas de meter archivos

| Método | Cómo | Ideal para |
|---|---|---|
| 🖱️ **Arrastrar y soltar** | Lleva el archivo desde tu carpeta hasta la zona punteada | Varios archivos a la vez |
| 📁 **Subir archivos** | Botón verde → ventana de selección (puedes elegir varios con `Ctrl+clic`) | Trabajo desde carpetas |
| 📸 **Usar cámara** | Botón *Usar cámara* (en móviles abre la cámara trasera directamente) | Documentos físicos |
| 📋 **Pegar con Ctrl+V** | Copia una captura (`Impr Pant` o recorte) y pega en la app | Capturas de pantalla |

> ⚠️ Los formatos no admitidos (por ejemplo `.heic` o `.docx`) se omiten y quedan anotados como **AVISO** en el registro.

---

## 7. La cola de trabajo, a fondo

Cada elemento muestra: **miniatura**, **nombre**, **estado**, **barra de progreso** y dos botones.

### Estados posibles

| Etiqueta | Significado |
|---|---|
| `pendiente` | En espera de proceso |
| `procesando` | El OCR está leyendo ahora mismo (línea ámbar barriendo la miniatura) |
| `completado ✓ 92 % conf.` | Terminado con éxito; muestra su confianza |
| `error` | Falló; puedes reintentarlo |

### Botones por elemento
- 🔄 **Reprocesar:** lo manda de nuevo al OCR (útil si salió mal o cambiaste de idioma).
- ✕ **Quitar:** lo elimina de la cola sin borrar su texto ya extraído.

### Controles globales
- **Procesar / Detener:** lanza la cola manualmente o frena al terminar el elemento en curso.
- **Vaciar:** limpia la lista completa.
- **Procesar automáticamente:** si está marcada, cada archivo nuevo se procesa al instante.
- **Barra inferior:** progreso conjunto con animación de rayas mientras trabaja.

> 📄 **PDF:** cada página se convierte en **un elemento independiente** de la cola (`documento.pdf · pág. 3`), para que puedas reprocesar solo la página que falló. Máximo 30 páginas por PDF.

---

## 8. El motor OCR y los idiomas

- El selector de la barra superior cambia el **modelo de reconocimiento**.
- Si cambias de idioma a mitad de sesión, la app **reinicia el motor automáticamente** y lo anota en el registro.
- La primera descarga de cada idioma puede tardar 10–30 s según tu conexión; luego queda en caché.
- **¿Español + Inglés o solo Español?**
  - Documentos con un solo idioma → elige ese idioma: **más preciso y más rápido**.
  - Documentos mixtos o con marcas/modelos en inglés → deja la combinación.

---

## 9. El editor estilo Word

Haz clic dentro de la hoja y escribe o corrige con total libertad. Selecciona texto y aplica formato desde la barra:

### Fila de herramientas (de izquierda a derecha)

| Botón | Función | Atajo |
|---|---|---|
| ↶ / ↷ | Deshacer / Rehacer | `Ctrl+Z` / `Ctrl+Y` |
| *Plex Sans ▾* | Cambiar la fuente del texto seleccionado | — |
| *Normal ▾* | Tamaño (Peq. → Enorme) | — |
| **N** | Negrita | `Ctrl+B` |
| *K* | Cursiva | `Ctrl+I` |
| S̲ | Subrayado | `Ctrl+U` |
| ~~T~~ | Tachado | — |
| 💧 | Color del texto (rueda de color) | — |
| 🖍️ | Resaltado / subrayador fluorescente | — |
| ⌫formato | Quita todo el formato de la selección | — |
| ≡ ×4 | Alineación: izquierda, centro, derecha, justificado | — |
| • / 1. | Lista con viñetas / lista numerada | — |
| ⇥ / ⇤ | Aumentar / reducir sangría | — |

> 💡 Los botones activos se iluminan en **verde oscuro** cuando el cursor está sobre texto con ese formato.

### La hoja de papel
- Cada archivo procesado crea un **bloque** con un encabezado ámbar:
  `▤ NOMBRE-ARCHIVO — 94 % CONFIANZA · 3.2 S — HORA`
- Los bloques se separan con línea discontinua: sabes siempre de qué imagen vino cada párrafo.
- El **título del documento** (arriba) es editable y se usa como nombre de archivo al descargar.

### Pie de estadísticas
| Métrica | Qué mide |
|---|---|
| **palabras / caracteres** | Tamaño del texto actual (se actualiza al escribir) |
| **elementos** | Cuántas imágenes/páginas se procesaron en la sesión |
| **confianza** | Media del % de seguridad del OCR (>85 % = muy fiable) |
| **tiempo OCR** | Suma de segundos de reconocimiento |

---

## 10. Botones de acción del documento

| Botón | Qué hace |
|---|---|
| **Copiar** | Lleva TODO el texto de la hoja al portapapeles |
| **Pegar** | Inserta el texto del portapapeles en la posición del cursor |
| **Descargar** | Guarda el documento como `.txt` (clic directo) |
| **Descargar ▾** | Menú desplegable: `.txt` (texto plano), `.html` (web con formato), `.doc` (se abre en **Word** conservando negritas, colores, etc.) |
| **Compartir** | Abre el menú nativo del sistema (móvil/Windows). Si no existe, copia el texto como alternativa |
| **Limpiar todo** | ⚠️ Pide confirmación en un cartel y reinicia la app: vacía hoja, cola, estadísticas y registro |

> 📝 Los archivos descargados se nombran automáticamente: `Titulo-del-documento_20260915-1830.doc`

---

## 11. El registro de actividad (log)

Consola inferior que documenta cada paso con **hora**, **nivel** y **mensaje**.

### Niveles y colores
| Nivel | Color | Significado |
|---|---|---|
| `SYS` | Azul | Arranque y reinicios del sistema |
| `INFO` | Verde apagado | Pasos normales (archivo añadido, motor cargando…) |
| `OK` | Verde brillante | Éxitos (extracción completada, descarga…) |
| `AVISO` | Ámbar | Avisos (formato omitido, proceso detenido…) |
| `ERROR` | Rojo | Fallos (archivo ilegible, sin conexión…) |

### Controles de la consola
- **Filtros:** `Todo` · `Avisos` (avisos+errores) · `Errores`.
- **copiar:** vuelca el registro completo al portapapeles (perfecto para pedir soporte).
- **limpiar:** borra las líneas visibles.
- **▾ contraer / ▴ expandir:** oculta o muestra la consola para ganar espacio.

> 🕵️ **Buen hábito:** si algo falla, filtra por *Errores*, pulsa *copiar* y pega ese texto al pedir ayuda: contiene la causa exacta.

---

## 12. Atajos de teclado

| Atajo | Acción |
|---|---|
| `Ctrl + Intro` | Procesar la cola |
| `Ctrl + S` | Descargar como `.txt` |
| `Ctrl + V` | Pegar una **imagen** capturada (fuera del editor) o texto (dentro del editor) |
| `Ctrl + B / I / U` | Negrita / cursiva / subrayado |
| `Ctrl + Z / Y` | Deshacer / rehacer |
| `Esc` | Cerrar el cartel de confirmación o el menú de descarga |

---

## 13. Consejos para máxima precisión

1. **Resolución:** imágenes de al menos **1200 px** de ancho. La app reescala sola, pero no puede inventar píxeles.
2. **Luz uniforme:** evita sombras y reflejos; la luz lateral crea zonas ilegibles.
3. **Encuadre recto:** cuanto menos inclinada esté la foto, mejor lee.
4. **Contraste:** texto oscuro sobre fondo claro es el caso ideal.
5. **Un idioma elegido** rinde más que la combinación bilingüe.
6. **Confianza baja (<70 %)** en el registro = revisa ese bloque a mano o reprocesa con mejor foto.
7. **PDF borrosos:** si el escaneo original es de baja calidad, el OCR no puede superarlo; re-escanea a 300 ppp si puedes.

---

## 14. Solución de problemas

| Síntoma | Causa probable | Solución |
|---|---|---|
| El indicador del motor queda en rojo al abrir | Sin conexión la primera vez | Conéctate y recarga la página (`F5`) |
| No reconoce nada y dice «sin texto detectado» | La imagen no contiene texto legible o está muy borrosa | Reprocesa con mejor foto; revisa la miniatura |
| El PDF no carga | PDF protegido con contraseña o dañado | Quita la protección o prueba otro archivo |
| *Compartir* no aparece en el menú | El navegador o equipo no soporta Web Share | Usa *Copiar* y pega donde quieras |
| *Pegar* avisa que el navegador bloqueó la lectura | Permiso de portapapeles denegado | Haz clic dentro de la hoja y usa `Ctrl+V` |
| Tarda mucho con PDF grandes | Muchas páginas a alta resolución | Procesa por lotes o desmarca el auto-proceso y lanza solo lo que necesites |
| Aparece un cartel que no se cierra | Versión antigua del archivo | Usa la versión **2.4** (ya corregido) o pulsa `Esc` |
| Se ve raro en pantallas pequeñas | Ventana estrecha | La app es responsive: en móvil las columnas se apilan solas |

---

## 15. Preguntas frecuentes

**¿Mis documentos se suben a algún servidor?**
No. OCR, edición y descargas ocurren íntegramente en tu equipo.

**¿Funciona sin internet?**
Sí, una vez cargado el motor la primera vez (el navegador lo guarda en caché). En modo privado la caché no persiste.

**¿Por qué el texto sale con errores en algunas palabras?**
El OCR estima caracteres; con confianza <85 % es normal corregir a mano. El editor existe justo para eso.

**¿Puedo procesar varias fotos a la vez?**
Sí: selecciónalas juntas o suéltalas todas; entran en cola y se procesan en orden.

**¿El `.doc` se abre bien en Word?**
Sí: es HTML con cabecera de Word; conserva negritas, colores, resaltados y listas.

**¿Hay límite de archivos?**
No por número; solo los PDF se limitan a 30 páginas por documento para no agotar la memoria.

---

## 16. Glosario rápido

| Término | Definición |
|---|---|
| **OCR** | Tecnología que convierte imágenes de texto en texto editable |
| **Confianza** | % de seguridad del motor sobre lo que leyó |
| **Cola** | Lista de espera de archivos por procesar |
| **Renderizar** | Convertir una página de PDF en imagen para poder leerla |
| **Portapapeles** | Memoria temporal del sistema para copiar/pegar |
| **Caché** | Copia local que el navegador guarda para no volver a descargar |

---

*Manual generado para LUMEN OCR v2.4 — Septiembre 2026.*
*¿Dudas? Copia el registro (botón **copiar** de la consola) y compártelo con quien te asista.*