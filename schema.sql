# Juachi Pan

App para registrar pedidos de pan, gastos en insumos e ingresos por venta.
Funciona como app instalable en el celular y guarda todo en una base de datos propia (Supabase).

## 1. Crear la base de datos en Supabase

1. Andá a https://supabase.com → "Start your project" → creá una cuenta gratis.
2. Creá un proyecto nuevo (elegí una contraseña para la base, no hace falta recordarla para esto).
3. Esperá a que termine de aprovisionarse (1-2 minutos).
4. En el menú izquierdo, andá a **SQL Editor** → **New query**.
5. Abrí el archivo `schema.sql` de esta carpeta, copiá todo su contenido, pegalo ahí y tocá **Run**.
   Esto crea las tablas `orders`, `expenses` e `incomes`.
6. Andá a **Project Settings** (ícono de engranaje) → **API**.
   Anotá dos datos que vas a necesitar en el paso 3:
   - **Project URL** (algo como `https://xxxxx.supabase.co`)
   - **anon public key** (una clave larga que empieza con `eyJ...`)

## 2. Subir el código a GitHub

1. Andá a https://github.com → creá una cuenta si no tenés.
2. Creá un repositorio nuevo, por ejemplo `juachi-pan` (puede ser privado o público).
3. Subí **todos los archivos de esta carpeta** (`index.html`, `style.css`, `app.js`, `manifest.json`, `sw.js`, `schema.sql`, la carpeta `icons/`) a ese repositorio.
   - Más fácil sin usar la terminal: en la página del repo, "Add file" → "Upload files" → arrastrá todos los archivos y carpetas → "Commit changes".

> Nota sobre privacidad: la "anon key" de Supabase la vas a cargar después, *dentro de la app, en tu navegador* (no queda escrita en el código que subís a GitHub). Aun así, esa clave queda guardada en el navegador de cada dispositivo donde uses la app — no es información súper secreta, pero evitá compartirla.

## 3. Publicar con Vercel

1. Andá a https://vercel.com → "Sign up" → entrá con tu cuenta de GitHub.
2. "Add New..." → "Project" → elegí el repositorio `juachi-pan`.
3. Dejá la configuración por defecto (no hace falta build command, es un sitio estático) → **Deploy**.
4. En un minuto te da una URL pública, algo como `https://juachi-pan.vercel.app`.

(Netlify funciona exactamente igual si lo preferís: "Add new site" → "Import from GitHub" → mismo repo → Deploy.)

## 4. Conectar la app con tu base de datos

1. Abrí la URL que te dio Vercel desde el celular.
2. La primera vez te va a pedir la **Project URL** y la **anon key** de Supabase (las del paso 1.6). Pegalas y tocá "Guardar y conectar".
3. Listo, ya está usando tu base de datos.

## 5. Instalar como app en el celular

- **iPhone (Safari):** ícono de compartir → "Agregar a pantalla de inicio".
- **Android (Chrome):** menú (⋮) → "Instalar app" / "Agregar a pantalla de inicio".

Te va a quedar el ícono de "Juachi Pan" como una app más, sin barra de navegador.

## Actualizar la app más adelante

Si querés cambiar algo del diseño o agregar una función, volvé a esta conversación,
pedímelo, y subí los archivos nuevos a GitHub (mismo paso "Upload files", reemplazando
los que cambien). Vercel vuelve a publicar solo en cuanto detecta el cambio en el repo.

## Sobre la privacidad de los datos

Activamos seguridad a nivel de fila (RLS) en las tres tablas, pero con una política que
permite leer y escribir a cualquiera que tenga tu "anon key". Para un uso personal esto
es normal y lo usa muchísima gente, pero tené en cuenta:
- Si el repositorio de GitHub es **público**, no pongas la anon key en el código (no lo
  hicimos: se carga a mano en el navegador, así que está bien).
- Si en algún momento querés más seguridad (por ejemplo, login con usuario y contraseña
  para vos), se puede agregar Supabase Auth más adelante — avisame y lo armamos.
