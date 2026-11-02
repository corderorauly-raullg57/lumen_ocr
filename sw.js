/* LUMEN OCR — copia sin conexión (service worker)
   Guarda la app y sus librerías en el navegador para que funcione aunque
   no haya internet ni servidor. Cambia VERSION al publicar una actualización. */
const VERSION = 'lumen-ocr-3.1.1';
const SHELL_CACHE = VERSION;
const RUNTIME_CACHE = 'lumen-ocr-recursos';   // se conserva entre versiones (motor, idiomas descargados…)

const SHELL = [
  './', 'index.html', 'manifest.webmanifest', 'banner-lumen.jpg',
  'lib/icons/icon-192.png', 'lib/icons/icon-512.png',
  'lib/fonts/manrope.woff', 'lib/fonts/fraunces.woff', 'lib/fonts/jetbrains-mono.woff'
];
const OPTIONAL = [
  'lib/pdfjs/pdf.js', 'lib/pdfjs/pdf.worker.js',
  'lib/lang/spa.traineddata.gz', 'lib/lang/eng.traineddata.gz',
  'lib/tesseract/tesseract.min.js', 'lib/tesseract/worker.min.js',
  'lib/tesseract/tesseract-core-simd-lstm.wasm.js', 'lib/tesseract/tesseract-core-lstm.wasm.js'
];
const CDN_HOSTS = ['cdn.jsdelivr.net', 'unpkg.com', 'cdnjs.cloudflare.com'];

self.addEventListener('install', event => {
  event.waitUntil((async () => {
    const c = await caches.open(SHELL_CACHE);
    await c.addAll(SHELL);
    // De uno en uno y con límite de tiempo: lo que aún no exista se guardará al usarlo.
    for (const u of OPTIONAL) {
      const ctl = new AbortController(), t = setTimeout(() => ctl.abort(), 20000);
      try { const r = await fetch(u, { signal: ctl.signal, cache: 'no-store' }); if (r.ok) await c.put(u, r); else await r.arrayBuffer(); } catch (e) {}
      clearTimeout(t);
    }
  })());
});

self.addEventListener('activate', event => {
  event.waitUntil((async () => {
    const keys = await caches.keys();
    await Promise.all(keys.filter(k => k.startsWith('lumen-ocr-') && k !== SHELL_CACHE && k !== RUNTIME_CACHE).map(k => caches.delete(k)));
    await self.clients.claim();
  })());
});

self.addEventListener('message', event => {
  if (event.data && event.data.type === 'skipWaiting') self.skipWaiting();
});

function isPage(url, req) {
  return req.mode === 'navigate' || url.pathname.endsWith('/') || url.pathname.endsWith('/index.html');
}

async function networkFirst(req) {
  const c = await caches.open(SHELL_CACHE);
  try {
    const res = await fetch(req, { cache: 'no-store' });
    if (res && res.ok) c.put(req, res.clone());
    return res;
  } catch (e) {
    return (await caches.match(req)) || (await caches.match(new URL('index.html', self.registration.scope).href)) || Response.error();
  }
}

async function cacheFirst(req) {
  const hit = await caches.match(req);
  if (hit) return hit;
  const res = await fetch(req);
  if (res && (res.ok || res.type === 'opaque')) {
    const c = await caches.open(RUNTIME_CACHE);
    c.put(req, res.clone()).catch(() => {});
  }
  return res;
}

self.addEventListener('fetch', event => {
  const req = event.request;
  if (req.method !== 'GET') return;
  const url = new URL(req.url);
  const sameOrigin = url.origin === self.location.origin;
  if (sameOrigin && url.pathname.includes('/__lumen/')) return;          // servidor local: siempre en vivo
  if (sameOrigin && isPage(url, req)) { event.respondWith(networkFirst(req)); return; }
  if (sameOrigin && url.pathname.endsWith('/manifest.webmanifest')) { event.respondWith(networkFirst(req)); return; }
  if (sameOrigin || CDN_HOSTS.includes(url.hostname)) { event.respondWith(cacheFirst(req)); }
});
