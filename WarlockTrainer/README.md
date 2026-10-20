# 🔮 WarlockTrainer (WoW 3.3.5a - WotLK / Warmane Lordaeron)

[![WoW Version](https://img.shields.io/badge/WoW-3.3.5a%20(Build%2012340)-purple.svg)](#)
[![Realm](https://img.shields.io/badge/Warmane-Lordaeron%20%7C%20Icecrown-blue.svg)](#)
[![Class](https://img.shields.io/badge/Class-Warlock%20%28Brujo%29-9482c9.svg)](#)
[![Language](https://img.shields.io/badge/Language-Espa%C3%B1ol%20%7C%20English-green.svg)](#)

**WarlockTrainer** es un addon ligero y completo para **World of Warcraft: Wrath of the Lich King (3.3.5a)**, diseñado específicamente para resolver el problema clásico del leveo del Brujo: **saber exactamente cuándo visitar al instructor, qué habilidades desbloqueas, cuánto oro necesitas y cuál es el entrenador más cercano a tu ubicación.**

---

## 🎯 ¿Qué problema resuelve este Addon?

Al subir de nivel en servidores WotLK 1x (como Warmane Lordaeron):
1. **Pérdida de tiempo:** No sabes si en tu nivel actual vale la pena viajar a una capital para entrenar o si los nuevos hechizos se aprenden en el siguiente nivel par.
2. **Falta de oro:** Viajas hasta el instructor y descubres que no tienes suficiente plata/oro para aprender todos los hechizos y rangos.
3. **Pérdida de ubicación:** No sabes cuál es el entrenador más cercano a tu zona de leveo actual ni qué camino tomar.

**WarlockTrainer** te da toda esta información con 1 solo clic desde tu minimapa o con `/wt`.

---

## ✨ Características Principales

### 1. Base de Datos Completa de Hechizos (Niveles 1 a 80)
- Incluye todos los hechizos y rangos oficiales del Brujo en 3.3.5a:
  - Aflicción: *Corruption, Curse of Agony, Drain Soul, Drain Life, Life Tap, Fear, Seed of Corruption...*
  - Demonología: *Demon Armor, Fel Armor, Health Funnel, Create Healthstone, Create Soulstone, Demonic Circle...*
  - Destrucción: *Shadow Bolt, Immolate, Searing Pain, Rain of Fire, Hellfire, Incinerate, Soul Fire, Shadowflame...*
- **Tooltips nativos interactivos:** Al pasar el ratón por encima de cualquier hechizo se despliega el tooltip original del juego con daño, coste exacto de maná, tiempo de casteo y rango.
- **Detección en tiempo real del libro de hechizos:** Escanea automáticamente tu libro de habilidades para saber cuáles ya compraste y ocultarlas o marcarlas en verde.

### 2. Calculadora Financiera en Tiempo Real
- Compara los costes de los hechizos con las monedas actuales de tu bolsa (`GetMoney()`).
- Muestra el **Coste Total Pendiente** de todos los hechizos disponibles para tu nivel.
- **Indicador de color:**
  - 🟢 **Verde (`¡Alcanza!`):** Tienes suficiente oro en el inventario.
  - 🔴 **Rojo (`¡Sin Oro!`):** Te indica la cantidad exacta de oro/plata/cobre que te falta para poder pagarlo.

### 3. Localizador Inteligente de Entrenadores y Navegación
- Base de datos exhaustiva para **Alianza**, **Horda** y **Neutrales** en:
  - Reinos del Este (Ventormenta, Forjaz, Entrañas, Lunargenta, Villadorada, Kharanos, Cerrotajo, etc.).
  - Kalimdor (Orgrimmar, Cima del Trueno, Trinquete, etc.).
  - Terrallende (Shattrath, Honor Hold, Thrallmar).
  - Rasganorte (Dalaran, Borean Tundra, Howling Fjord).
- Detecta tu facción y tu zona actual. Si estás en la misma zona, calcula la distancia aproximada en yardas y te da las coordenadas `(X, Y)`.
- Si estás en otra zona, te sugiere la capital más cercana de ese continente.
- **Botón "Ruta":** Compatible con los addons más populares:
  - 📌 **TomTom** (añade la flecha de navegación).
  - 🗺️ **Cartographer** / `Cartographer_Waypoints` (añade el waypoint directo).
  - 🧭 **Carbonite** (añade el objetivo en el mapa).

### 4. Interfaz Gráfica (UI) y Filtros
- Cuatro pestañas de visualización rápida:
  - **[Disponibles]:** Hechizos de tu nivel actual o inferior que todavía no has aprendido.
  - **[Próximo Nivel]:** Te anticipa lo que desbloquearás en el siguiente tramo de nivel (por ej. si eres nivel 18, te muestra los de nivel 20).
  - **[Todos (1-80)]:** Explorador enciclopédico de todas las habilidades.
  - **[Aprendidos]:** Registro de lo que ya tienes.
- Mensajes informativos cuando estás al día para no dejar la pantalla en blanco.
- Ventana arrastrable y personalizable (recuerda la posición en pantalla).

### 5. Botón en el Minimapa y Alerta al Subir de Nivel
- **Icono en el Minimapa:** Botón morado arrastrable en círculo alrededor del minimapa.
  - Clic izquierdo: Abre/cierra el panel.
  - Clic derecho: Muestra el entrenador más cercano en el chat.
- **Aviso automático al subir de nivel:** Si alcanzas un nivel que tenga hechizos disponibles en el instructor, el addon emite un sonido y un mensaje en el chat recordándote ir al instructor, el coste y dónde está el más cercano.

### 6. Menú en la Configuración Oficial de Blizzard
- Registrado en **Escape -> Interfaz -> pestaña Accesorios -> WarlockTrainer**.
- Permite activar/desactivar alertas sonoras, ocultar/mostrar el botón del minimapa y alternar idioma.

---

## 📥 Guía de Instalación (Paso a Paso para Terceros)

1. **Descargar / Copiar la carpeta:**
   - Asegúrate de tener la carpeta llamada **`WarlockTrainer`** (la carpeta que contiene los archivos `.lua` y el archivo `WarlockTrainer.toc`).

2. **Copiar a la carpeta de AddOns:**
   - Abre la carpeta donde tienes instalado tu juego World of Warcraft 3.3.5a.
   - Navega hasta:
     ```text
     World of Warcraft \ Interface \ AddOns \
     ```
   - Pega allí la carpeta `WarlockTrainer`.
   - La ruta debe quedar exactamente así:
     ```text
     World of Warcraft\Interface\AddOns\WarlockTrainer\WarlockTrainer.toc
     World of Warcraft\Interface\AddOns\WarlockTrainer\Core.lua
     World of Warcraft\Interface\AddOns\WarlockTrainer\UI.lua
     World of Warcraft\Interface\AddOns\WarlockTrainer\Localization.lua
     World of Warcraft\Interface\AddOns\WarlockTrainer\Options.lua
     World of Warcraft\Interface\AddOns\WarlockTrainer\MinimapButton.lua
     World of Warcraft\Interface\AddOns\WarlockTrainer\Data\Spells.lua
     World of Warcraft\Interface\AddOns\WarlockTrainer\Data\Trainers.lua
     ```

3. **Activar en el juego:**
   - Si tienes el juego abierto, escribe en el chat `/reload` o reinicia el cliente.
   - En la pantalla de selección de personajes, haz clic en el botón **Accesorios** (o *AddOns*) abajo a la izquierda.
   - Verifica que **WarlockTrainer** tenga la casilla marcada.
   - *(Recomendado)* Marca la casilla superior **"Cargar accesorios antiguos"** (*Load out of date AddOns*).

---

## ⌨️ Comandos de Chat

| Comando | Acción |
| :--- | :--- |
| `/wt` | Abre o cierra la ventana principal de WarlockTrainer. |
| `/warlock-train` | Comando alternativo para abrir/cerrar la ventana. |
| `/wtrain` | Comando corto alternativo. |
| `/wt es` | Cambia el idioma de la interfaz a **Español**. |
| `/wt en` | Cambia el idioma de la interfaz a **English**. |
| `/wt ruta` o `/wt way` | Fija el waypoint en TomTom, Cartographer o Carbonite hacia el entrenador más cercano. |
| `/wt trainer` o `/wt loc` | Imprime en el chat el nombre y las coordenadas del entrenador más cercano. |
| `/wt help` | Muestra la lista de comandos disponibles. |

---

## 🧩 Compatibilidad y Requisitos

- **Versión de WoW:** 3.3.5a (Wrath of the Lich King, Build 12340).
- **Servidores probados:** Warmane (Lordaeron, Icecrown, Onyxia), ChromieCraft, Dalaran-WoW, servidores privados 3.3.5a.
- **Addons compatibles:**
  - ✅ **ElvUI**
  - ✅ **Cartographer** (`Cartographer_Waypoints`)
  - ✅ **Carbonite**
  - ✅ **TomTom**
- **Clase requerida:** Diseñado para **Brujos** (Warlocks). Si se abre con otra clase, muestra una notificación amigable avisando que el personaje no es Brujo.

---

## ❓ Preguntas Frecuentes (FAQ)

**P: ¿Por qué cuando abro el addon la pestaña "Disponibles" dice que estoy al día?**  
*R:* Significa que ya has aprendido todas las habilidades que tu nivel actual te permite. Haz clic en la pestaña **[Próximo Nivel]** para ver qué hechizos aprenderás en tu siguiente subida.

**P: ¿Puedo mover el botón del minimapa si me estorba con otro addon?**  
*R:* Sí, simplemente mantén presionado el clic izquierdo sobre el botón morado y arrástralo alrededor del borde de tu minimapa. También puedes ocultarlo por completo desde **Esc -> Interfaz -> Accesorios -> WarlockTrainer**.

**P: ¿El addon consume mucha memoria o baja los FPS?**  
*R:* No. El addon utiliza carga estática optimizada para 3.3.5a y el sistema `FauxScrollFrame` nativo de Blizzard, consumiendo menos de 0.2 MB de memoria RAM.

---

## 📄 Créditos y Licencia

Desarrollado para la comunidad de World of Warcraft 3.3.5a.  
Licencia libre para uso personal, distribución y modificación en hermandades y servidores privados.
