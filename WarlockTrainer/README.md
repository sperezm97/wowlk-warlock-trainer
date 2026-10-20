# 🔮 WarlockTrainer (WoW 3.3.5a - WotLK / Warmane Lordaeron)

[![WoW Version](https://img.shields.io/badge/WoW-3.3.5a%20(Build%2012340)-purple.svg)](#)
[![Realm](https://img.shields.io/badge/Warmane-Lordaeron%20%7C%20Icecrown-blue.svg)](#)
[![Class](https://img.shields.io/badge/Class-Warlock%20%28Brujo%29-9482c9.svg)](#)
[![Language](https://img.shields.io/badge/Language-Espa%C3%B1ol%20%7C%20English-green.svg)](#)

**WarlockTrainer** es un addon ligero y completo para **World of Warcraft: Wrath of the Lich King (3.3.5a)**, diseñado específicamente para resolver dos problemas fundamentales del leveo del Brujo:
1. **Saber cuándo ir al instructor, qué habilidades desbloqueas, cuánto oro necesitas y cuál es el entrenador más cercano.**
2. **Llevar el seguimiento exhaustivo de todas las misiones de clase:** dónde empiezan, dónde se entregan, qué materiales requieren en tus bolsas y **si ya las tienes completadas o en progreso**.

---

## ✨ Características Principales

### 1. Centro de Misiones de Clase (Class Quests Tracker) 📜
- **Revisión en tiempo real de misiones completadas:** El addon comprueba si ya conoces la habilidad o montura (`IsSpellKnown`), si tienes el objeto de recompensa en tu inventario o si la misión figura en el historial del servidor (`GetQuestsCompleted`).
- **Misiones incluidas (Alianza y Horda):**
  - **Nivel 10:** Invocación del Abisario (*Voidwalker* - cadenas para Humanos, Gnomos, Orcos, No-muertos y Elfos de Sangre).
  - **Nivel 20:** Invocación de la Súcubo (*Succubus*).
  - **Nivel 30:** Invocación del Manáfago (*Felhunter* - cadena de Strahad Farsan en Trinquete).
  - **Nivel 31:** Túnica de Sangre Dorada Encantada (*Enchanted Gold Bloodrobe* - BiS de leveo).
  - **Nivel 50:** Invocación del Infernal (*Inferno*) y misiones del Templo Sumergido.
  - **Nivel 60:** Montura Épica 100% (*Corcel de la Muerte de Xoroth* / *Dreadsteed*).
  - **Nivel 60:** Ritual de la Fatalidad (*Ritual of Doom* / *Doomguard*).
- **Checklist de materiales en tus bolsas en tiempo real:**
  - Para misiones como el Corcel de Xoroth o la Túnica de Arcana, el addon lee tus bolsas y te indica exactamente qué tienes y qué te falta:
    - `[✓] 35/35 Escamas de dragón negro (¡Listo!)`
    - `[✗] 12/25 Runas oscuras (Faltan 13 - Scholomance / Subasta)`
- **Ubicación y botón de ruta directo:**
  - Muestra el PNJ de inicio y fin con sus coordenadas exactas `(X, Y)`.
  - Botón **[Ruta PNJ]** para fijar la flecha de navegación directa con **Cartographer**, **TomTom** o **Carbonite**.

### 2. Base de Datos Completa de Hechizos (Niveles 1 a 80) 📖
- Incluye todos los hechizos y rangos oficiales del Brujo en 3.3.5a: Aflicción, Demonología y Destrucción.
- **Tooltips nativos interactivos:** Al pasar el ratón se despliega el tooltip original del juego con daño, coste de maná, tiempo de casteo y rango.
- **Detección del libro de hechizos:** Marca automáticamente en verde lo que ya compraste y filtra lo que te falta.

### 3. Calculadora Financiera en Tiempo Real 💰
- Compara los costes de los hechizos con tu dinero actual (`GetMoney()`).
- Muestra el **Coste Total Pendiente** de todos los hechizos de tu nivel.
- Indicador visual: 🟢 Verde (`¡Alcanza!`) o 🔴 Rojo (`¡Sin Oro! - Faltan Xg Ys Zc`).

### 4. Localizador Inteligente de Entrenadores 🧭
- Base de datos exhaustiva para **Alianza**, **Horda** y **Neutrales** en Reinos del Este, Kalimdor, Terrallende y Rasganorte.
- Si estás en la misma zona, calcula la distancia aproximada en yardas y te da las coordenadas `(X, Y)`.
- Si estás en otra zona, te sugiere la capital más cercana de ese continente.
- Botón **"Ruta"** con soporte para **Cartographer**, **TomTom** y **Carbonite**.

### 5. Pestañas de la Interfaz
- **[Disponibles]:** Hechizos de tu nivel actual o inferior que todavía no has aprendido.
- **[Próximo Nivel]:** Qué desbloquearás en el siguiente tramo de nivel (para planificar tu viaje).
- **[Todos (1-80)]:** Catálogo completo de todas las habilidades.
- **[Aprendidos]:** Registro de lo que ya compraste.
- **[Misiones]:** Centro de seguimiento de misiones de clase, guías, materiales y comprobación de estado.

---

## 📥 Guía de Instalación (Paso a Paso)

1. Abre la carpeta donde tienes instalado World of Warcraft 3.3.5a.
2. Entra en:
   ```text
   World of Warcraft \ Interface \ AddOns \
   ```
3. Copia la carpeta **`WarlockTrainer`** dentro de `AddOns`.
4. La estructura de archivos debe quedar así:
   ```text
   World of Warcraft\Interface\AddOns\WarlockTrainer\WarlockTrainer.toc
   World of Warcraft\Interface\AddOns\WarlockTrainer\Core.lua
   World of Warcraft\Interface\AddOns\WarlockTrainer\UI.lua
   World of Warcraft\Interface\AddOns\WarlockTrainer\Options.lua
   World of Warcraft\Interface\AddOns\WarlockTrainer\Localization.lua
   World of Warcraft\Interface\AddOns\WarlockTrainer\MinimapButton.lua
   World of Warcraft\Interface\AddOns\WarlockTrainer\Data\Spells.lua
   World of Warcraft\Interface\AddOns\WarlockTrainer\Data\Trainers.lua
   World of Warcraft\Interface\AddOns\WarlockTrainer\Data\Quests.lua
   ```
5. Inicia el juego (o escribe `/reload` si ya lo tienes abierto).
6. En la pantalla de personajes, haz clic en **Accesorios** y verifica que **WarlockTrainer** esté activado con la opción *"Cargar accesorios antiguos"* marcada.

---

## ⌨️ Comandos de Chat

| Comando | Acción |
| :--- | :--- |
| `/wt` | Abre o cierra la ventana principal de WarlockTrainer. |
| `/warlock-train` | Comando alternativo para abrir/cerrar la ventana. |
| `/wtrain` | Comando corto alternativo. |
| `/wt es` | Cambia el idioma a **Español**. |
| `/wt en` | Cambia el idioma a **English**. |
| `/wt ruta` o `/wt way` | Fija el waypoint en Cartographer, TomTom o Carbonite hacia el entrenador más cercano. |
| `/wt trainer` o `/wt loc` | Imprime en el chat el nombre y las coordenadas del entrenador más cercano. |
| `/wt help` | Muestra la lista de ayuda. |

---

## 🧩 Compatibilidad

- **Versión de WoW:** 3.3.5a (Wrath of the Lich King, Build 12340).
- **Servidores:** Warmane (Lordaeron, Icecrown, Onyxia), ChromieCraft, Dalaran-WoW y cualquier servidor privado 3.3.5a.
- **Addons soportados:** ElvUI, Cartographer (`Cartographer_Waypoints`), Carbonite y TomTom.
