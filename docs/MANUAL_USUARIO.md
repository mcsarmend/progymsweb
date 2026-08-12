# 📘 Manual de Usuario PROGYMS

**Versión:** 1.0  
**Última actualización:** 2026  
**Idioma:** Español  
**Plataforma:** Web responsive (desktop, tablet, móvil)

---

## 📋 Tabla de Contenidos

### Sección Pública (Sin Autenticación)

1. [Introducción](#introducción)
2. [Inicio Rápido](#inicio-rápido)
3. [Navegación Principal](#navegación-principal)
4. [Página de Inicio](#página-de-inicio)
5. [Catálogo de Productos](#catálogo-de-productos)
6. [Página de Nosotros](#página-de-nosotros)
7. [Contacto y Ubicación](#contacto-y-ubicación)
8. [Preguntas Frecuentes](#preguntas-frecuentes)
9. [Políticas](#políticas)

### Sección Autenticada (AdminLTE)

10. [Iniciar Sesión](#iniciar-sesión)
11. [Panel Administrativo (AdminLTE)](#panel-administrativo-adminlte)
    - [Dashboard/Home](#1️⃣-sección-de-inicio-homedashboard)
    - [Módulo de Ventas](#2️⃣-módulo-de-ventas)
    - [Módulo de Inventario](#3️⃣-módulo-de-inventario)
    - [Módulo de Clientes](#4️⃣-módulo-de-clientes)
    - [Módulo de Compras](#6️⃣-módulo-de-compras)
    - [Módulo de Proveedores](#7️⃣-módulo-de-proveedores)
    - [Módulo de Asistencias](#8️⃣-módulo-de-asistencias)
    - [Módulo de Vendedores](#9️⃣-módulo-de-vendedores)
    - [Módulo CxC](#🔟-módulo-de-cuentas-por-cobrar-cxc)
    - [Módulo de Reportes](#1️⃣1️⃣-módulo-de-reportes)
    - [Módulo de Tareas](#1️⃣2️⃣-módulo-de-tareas)
    - [Gestión de Usuarios](#1️⃣3️⃣-módulo-de-usuarios)
    - [Administración de Banners](#1️⃣4️⃣-administración-de-banners)

### Secciones Generales

12. [Roles y Permisos](#roles-y-permisos)
13. [Solución de Problemas](#solución-de-problemas)
14. [Glosario](#glosario)
15. [Recomendaciones de UX](#recomendaciones-de-ux)

---

## Introducción

PROGYMS es una plataforma especializada en **suplementación deportiva de alta calidad**. Nuestro objetivo es proporcionar a atletas, personas fitness y entusiastas del entrenamiento, acceso a productos originales de marcas reconocidas internacionalmente con asesoría profesional personalizada.

### Características Principales

- 🏆 **Catálogo completo** de suplementos deportivos
- 💬 **Contacto directo** por WhatsApp con múltiples sucursales
- 📍 **Ubicación en Google Maps** para localización fácil
- ❓ **Sección de FAQs** con respuestas a preguntas frecuentes
- 📋 **Políticas claras** de envío, privacidad y uso
- 🔐 **Portal de usuarios** con acceso autenticado
- 📱 **Diseño responsive** para cualquier dispositivo

---

## Inicio Rápido

### Pasos Básicos para Explorar PROGYMS

**Paso 1:** Acceder al sitio web  
→ Ingresa a la URL principal de PROGYMS en tu navegador

**Paso 2:** Explorar el catálogo  
→ Haz clic en "Productos" en el menú superior

**Paso 3:** Contactar sucursales  
→ Haz clic en el botón verde de WhatsApp en la esquina inferior derecha

**Paso 4:** Obtener información adicional  
→ Consulta las FAQs, políticas y nuestra historia en el pie de página

---

## Navegación Principal

### Estructura del Menú Superior

La barra de navegación principal se encuentra en la parte superior de todas las páginas públicas:

```
[LOGO PROGYMS]  →  Inicio  →  Productos  →  Nosotros  →  Contacto  →  Iniciar Sesión
```

| Opción             | Descripción                                  | Acceso       |
| ------------------ | -------------------------------------------- | ------------ |
| **Inicio**         | Página principal con productos destacados    | `/`          |
| **Productos**      | Catálogo completo de suplementos             | `/productos` |
| **Nosotros**       | Información sobre la empresa y sus servicios | `/acerca`    |
| **Contacto**       | Ubicación, mapa y canales de WhatsApp        | `/contacto`  |
| **Iniciar Sesión** | Portal de usuarios registrados               | `/logininit` |

### Menú Responsivo (Móvil)

En dispositivos móviles, el menú se convierte en un menú hamburguesa (☰) en la esquina superior derecha. Al hacer clic, se expande mostrando todas las opciones.

---

## Página de Inicio

### Propósito

La página de inicio es tu punto de partida. Aquí encontrarás:

- Carrusel de banners promocionales
- Productos destacados
- Información sobre PROGYMS
- Acceso rápido a todas las secciones

### Elementos Principales

#### 1️⃣ Carrusel de Banners (Owl Carousel)

**Qué es:**  
Una galería de imágenes rotativas que muestra promociones y anuncios principales.

**Características:**

- ✅ Rotación automática
- ✅ Navegación con puntos (dots) inferiores
- ✅ Responsive (se adapta a cualquier pantalla)
- ✅ Se pausa automáticamente con el ratón

**Cómo usarlo:**

```
1. Observa las imágenes que van cambiando automáticamente
2. Haz clic en los puntos de abajo para saltar a una imagen específica
3. En dispositivos táctiles, desliza hacia la izquierda o derecha
```

**Especificaciones técnicas:**

- Dimensiones recomendadas de banners: **1600 × 697 píxeles**
- Formato: JPG o JPEG
- Peso máximo: 2 MB por banner
- Cantidad: 6 banners en rotación

#### 2️⃣ Productos Destacados

**Qué es:**  
Una selección de 3 productos principales que representan el catálogo.

**Información mostrada por producto:**

```
┌─────────────────────────────────┐
│      [Imagen del Producto]      │
├─────────────────────────────────┤
│ 📦 Nombre del Producto          │
│ 💰 Precio (MXN)                 │
│ 📝 Descripción breve            │
│ ⭐ Calificación (5 estrellas)    │
└─────────────────────────────────┘
```

**Productos mostrados:**

1. **Gold Standard 5.6Lb** - $1,290 MXN
    - 24 gramos de proteína por servicio
    - Ideal para ganar masa muscular

2. **Creatina XS 1kg Ronnie** - $450 MXN
    - Incrementa fuerza, potencia y recuperación
    - Fórmula micronizada

3. **Monster 473ml** - $30 MXN
    - Energía instantánea
    - Mayor concentración y resistencia

#### 3️⃣ Sección "¿Por qué elegir PROGYMS?"

**Contenido:**

- Misión de la empresa
- Ventajas competitivas
- Tipos de productos disponibles:
    - Proteínas Premium
    - Creatinas Micronizadas
    - Pre Entrenos
    - Aminoácidos BCAA
    - Asesoría Personalizada

**Botón de Acción:** "Conócenos" → Lleva a la página de Contacto

---

## Catálogo de Productos

### Propósito

El catálogo de productos es la sección más importante. Permite a los usuarios explorar, filtrar y conocer todos los suplementos disponibles.

### Acceso

```
Clic en "Productos" en el menú superior
O directamente en: https://progyms.com/productos
```

### Elementos Principales

#### 1️⃣ Interfaz de Productos

Cada producto se presenta en una tarjeta con:

```
┌────────────────────────────────────┐
│  Badge Stock (si está disponible)  │
│  ┌──────────────────────────────┐  │
│  │    [Imagen del Producto]     │  │ ← Hover: Zoom 1.05x
│  └──────────────────────────────┘  │
├────────────────────────────────────┤
│ 📦 Nombre del Producto             │
│ 🏭 Marca (con icono)               │
│ 📂 Categoría                       │
├────────────────────────────────────┤
│ 💰 Precios:                        │
│    • Precio Base: $XXX MXN         │
│    • Precio Oferta: $XXX MXN       │
│    • Precio Premium: $XXX MXN      │
├────────────────────────────────────┤
│ ⭐ Calificación (5 estrellas)      │
└────────────────────────────────────┘
```

#### 2️⃣ Filtros de Búsqueda

**Disponibles:**

- **Por Categoría** - Selecciona el tipo de suplemento
- **Por Marca** - Filtra por fabricante
- **Por Rango de Precio** - Busca según tu presupuesto

**Cómo usar:**

```
1. Haz clic en el filtro deseado
2. Se mostrarán solo los productos que coincidan
3. Puedes combinar múltiples filtros
4. Los resultados se actualizan automáticamente
```

#### 3️⃣ Información Detallada del Producto

**Datos mostrados:**

- Nombre completo
- Marca y categoría
- Descripción
- Precios en diferentes presentaciones
- Stock disponible
- Calificación de usuarios

**Presentaciones de Precios:**
| Tipo | Descripción |
|------|-------------|
| **Precio Base** | Tarifa estándar para compras regulares |
| **Precio Oferta** | Descuento temporal o promocional |
| **Precio Premium** | Acceso especial para usuarios Platinum |

#### 4️⃣ Efectos Visuales

- **Hover en tarjeta:** Se eleva ligeramente con sombra aumentada
- **Zoom en imagen:** La imagen se amplifica un 5% al pasar el ratón
- **Efectos suaves:** Todas las transiciones son fluidas (0.3s)

### Recomendaciones de Uso

| Acción                    | Beneficio                             |
| ------------------------- | ------------------------------------- |
| Explorar sin filtros      | Ver todo el catálogo disponible       |
| Usar filtros de categoría | Encontrar rápidamente lo que buscas   |
| Leer descripciones        | Entender características y beneficios |
| Verificar stock           | Asegurar disponibilidad inmediata     |
| Comparar precios          | Identificar mejores ofertas           |

---

## Página de Nosotros

### Propósito

Conocer la historia, misión y valores de PROGYMS, así como sus servicios principales.

### Acceso

```
Clic en "Nosotros" en el menú superior
O directamente en: https://progyms.com/acerca
```

### Secciones Principales

#### 1️⃣ Banner - "Nuestra Historia"

```
┌─────────────────────────────────┐
│   CONOCE PROGYMS                │
│   NUESTRA HISTORIA              │
└─────────────────────────────────┘
```

#### 2️⃣ Quiénes Somos

**Misión:**
PROGYMS nace con el objetivo de ofrecer productos originales y asesoría profesional para atletas, personas fitness y amantes del entrenamiento.

**Enfoque:**

- Trabajamos únicamente con marcas reconocidas
- Ayudamos a mejorar rendimiento, recuperación y composición corporal
- Ofrecemos asesoría personalizada

**Redes Sociales:**

- 📘 [Facebook](https://www.facebook.com/people/Progyms/)
- 📷 [Instagram](https://www.instagram.com/gprogyms/)

#### 3️⃣ Servicios Ofrecidos

| Icono | Servicio               | Descripción                                                       |
| ----- | ---------------------- | ----------------------------------------------------------------- |
| 💪    | Asesoría Personalizada | Te ayudamos a seleccionar suplementos según tus objetivos físicos |
| 🚚    | Entrega Rápida         | Envíos locales en la zona metropolitana                           |
| ✅    | Productos Originales   | Garantía de autenticidad en todos nuestros artículos              |
| 🎁    | Promociones Especiales | Descuentos exclusivos para clientes frecuentes                    |

---

## Contacto y Ubicación

### Propósito

Facilitar la comunicación directa y mostrar dónde ubicar las sucursales físicas.

### Acceso

```
Clic en "Contacto" en el menú superior
O directamente en: https://progyms.com/contacto
```

### Componentes Principales

#### 1️⃣ Mapa Interactivo

**Ubicación principal:** 19.593965, -99.2530777 (Ciudad de México)

**Características:**

- Mapa de Google Maps integrado
- Zoom interactivo
- Visualización de satélite disponible
- Compatible con dispositivos móviles

**Cómo usar:**

```
1. Haz clic en el mapa para interactuar
2. Amplía/reduce con los controles + y -
3. Arrastra para explorar áreas adecentes
4. Haz clic en la ubicación para más detalles
```

#### 2️⃣ Botón Flotante de WhatsApp 🟢

**Qué es:**  
Un botón verde fijo en la esquina inferior derecha que abre un modal con opciones de contacto.

**Ubicación:**  
Esquina inferior derecha, 30px desde los bordes

**Estilos:**

- Color: #25D366 (verde WhatsApp)
- Tamaño: 65 × 65 píxeles
- Efecto hover: Cambia a color más oscuro y aumenta tamaño

**Badge:**

- Pequeño círculo rojo superior derecho
- Muestra número de sucursales disponibles

#### 3️⃣ Modal de Sucursales

**Cómo abrirlo:**

1. Haz clic en el botón flotante de WhatsApp
2. Se abrirá un modal con todas las sucursales

**Botones disponibles:**

| #   | Sucursal                   | Número            | Zona           |
| --- | -------------------------- | ----------------- | -------------- |
| 1   | Town Center Nicolás Romero | +52 1 557 8397643 | Nicolás Romero |
| 2   | San Esteban Naucalpan      | +52 1 564 8149566 | Naucalpan      |
| 3   | Serviplaza Coacalco        | +52 1 553 1216226 | Coacalco       |
| 4   | Bodega Atizapán            | +52 1 551 2415377 | Atizapán       |
| 5   | Platinum                   | +52 1 566 5110366 | Premium        |

**Acciones al hacer clic:**

- Se abre WhatsApp Web o la aplicación móvil
- Se crea un chat preestablecido con la sucursal
- La conversación se abre automáticamente

#### 4️⃣ Información General de Contacto

```
PROGYMS - Suplementación Deportiva

📍 Ubicación: Zona Metropolitana de la Ciudad de México
📱 Contacto: Múltiples sucursales vía WhatsApp
🏪 Tipo: Tienda especializada en suplementos
```

**Descripción:**
"Somos una tienda especializada en suplementos deportivos. Ofrecemos proteínas, creatinas, vitaminas, pre entrenos y asesoría para ayudarte a alcanzar tus objetivos. Atención personalizada. Envíos locales. Productos originales."

#### 5️⃣ Sección de Testimonios

**Carrusel de Clientes Satisfechos:**

- Rotación automática de testimonios
- Navegación con puntos
- Muestra experiencias de usuarios
- 5 estrellas de calificación

---

## Preguntas Frecuentes

### Propósito

Resolver dudas comunes sobre productos, servicios y políticas sin necesidad de contacto directo.

### Acceso

```
Pie de página en cualquier página → Clic en "FAQ"
O directamente en: https://progyms.com/preguntasfrecuentes
```

### Estructura de FAQs

#### 1️⃣ Diseño Interactivo de Acordeón

Cada pregunta es un elemento desplegable:

```
┌─────────────────────────────────────┐
│ ❓ ¿Pregunta importante?        ▼   │ ← Clickeable
├─────────────────────────────────────┤
│ Respuesta detallada aquí...         │ ← Se abre al hacer clic
│ • Punto 1                           │
│ • Punto 2                           │
│ • Punto 3                           │
└─────────────────────────────────────┘
```

#### 2️⃣ Cómo Usar

**Paso 1:** Lee el título de la pregunta  
**Paso 2:** Haz clic para expandir la respuesta  
**Paso 3:** Lee la información completa  
**Paso 4:** Haz clic nuevamente para contraer (opcional)

**Efectos visuales:**

- Flecha rotada 180° cuando está abierto
- Animación suave de apertura/cierre (0.4s)
- Sombra aumentada al pasar el ratón
- Bordes redondeados para mejor estética

#### 3️⃣ Categorías Típicas de Preguntas

| Categoría        | Ejemplos                                           |
| ---------------- | -------------------------------------------------- |
| **Productos**    | ¿Cuáles son los mejores suplementos? ¿Cómo elegir? |
| **Compras**      | ¿Cómo comprar? ¿Cuáles son los métodos de pago?    |
| **Envíos**       | ¿Cuánto tiempo tarda? ¿Hay envíos nacionales?      |
| **Devoluciones** | ¿Puedo devolver? ¿Cuál es el procedimiento?        |
| **Asesoría**     | ¿Me ayudan a elegir? ¿Es gratis la consulta?       |

---

## Políticas

### Propósito

Informar a los usuarios sobre derechos, responsabilidades y términos de servicio.

### Acceso General

Todas las políticas están disponibles en el pie de página:

```
[Pie de página]
├─ Política de Envío y Devoluciones
├─ Política de Privacidad
└─ Política de Uso Dirigido
```

### 1️⃣ Política de Envío y Devoluciones

**URL:** `/politicaenvio`

#### Envíos

| Aspecto       | Detalles                                  |
| ------------- | ----------------------------------------- |
| **Cobertura** | Zona metropolitana de la Ciudad de México |
| **Tiempos**   | 1-3 días hábiles según la zona            |
| **Costo**     | Varía según distancia (consultar)         |
| **Método**    | Transporte terrestre asegurado            |

**Proceso de Envío:**

```
1. Cliente realiza pedido
2. Se procesa en 24 horas
3. Se asigna transportista
4. Se envía confirmación con rastreo
5. Entrega en domicilio indicado
```

#### Devoluciones

**Plazo:** 30 días desde la compra

**Condiciones:**

- ✅ Producto sin abrir
- ✅ Embalaje original intacto
- ✅ Comprobante de compra disponible

**Proceso:**

```
1. Contactar a PROGYMS con comprobante
2. Inspección del producto
3. Aprobación de devolución
4. Reembolso o cambio según política
```

**No son devolvibles:**

- ❌ Productos abiertos o dañados por el cliente
- ❌ Suplementos sin comprobante
- ❌ Artículos comprados hace más de 30 días

#### Garantía

- **Autenticidad:** Todos los productos son 100% originales
- **Calidad:** Garantía contra defectos de fabricación
- **Protección:** Aseguro contra daños en tránsito

### 2️⃣ Política de Privacidad

**URL:** `/politicaprivacidad`

#### Datos Recopilados

| Dato                    | Propósito                         |
| ----------------------- | --------------------------------- |
| **Nombre**              | Identificación de usuario         |
| **Email**               | Comunicación y notificaciones     |
| **Teléfono**            | Contacto para entregas            |
| **Dirección**           | Envío de productos                |
| **Historial de compra** | Personalización y recomendaciones |

#### Protección de Datos

- 🔒 Encriptación SSL de datos sensibles
- 🔐 Acceso restringido a personal autorizado
- 🛡️ Cumplimiento con regulaciones de protección de datos
- 📋 No compartimos datos con terceros sin consentimiento

#### Derechos del Usuario

✅ Acceder a tus datos personales  
✅ Solicitar corrección de información  
✅ Solicitar eliminación de datos (excepto necesarios por ley)  
✅ Retirar consentimiento en cualquier momento

### 3️⃣ Política de Uso Dirigido

**URL:** `/politicadeusodirigido`

**Contenido:** Términos y condiciones para el uso responsable de la plataforma.

---

## Panel Administrativo (AdminLTE)

### Propósito

Después de iniciar sesión, los usuarios acceden al panel administrativo completo con funcionalidades de gestión empresarial avanzada.

### Acceso

```
Después de login correctamente → Se redirige automáticamente a /home o /dashboard
O directamente en: https://progyms.com/dashboard
```

### Estructura General del Panel AdminLTE

```
┌─────────────────────────────────────────────────────┐
│  HEADER: Logo | Search | User Profile | Logout     │
├──────────────┬──────────────────────────────────────┤
│              │                                      │
│   SIDEBAR    │         MAIN CONTENT AREA            │
│   MENU       │                                      │
│              │   • Paneles de control               │
│   • Ventas   │   • Tablas de datos                 │
│   • Compras  │   • Formularios                     │
│   • Reportes │   • Gráficos                        │
│   • etc...   │   • Exportación (PDF/Excel)        │
│              │                                      │
└──────────────┴──────────────────────────────────────┘
```

### 1️⃣ Sección de Inicio (Home/Dashboard)

**Ubicación:** Primera página después del login

**Contenido principal:**

#### Tareas Asignadas

Una tabla interactiva que muestra todas las tareas delegadas al usuario:

```
┌────────────────────────────────────────────┐
│           📋 MIS TAREAS                    │
├────────────────────────────────────────────┤
│  Estado | Fecha Inicio | Fecha Fin | Asunto│
├────────────────────────────────────────────┤
│  ⚠️     | 2026-01-15  | 2026-01-20 |Revisar│
│  ✅    | 2026-01-10  | 2026-01-15 |Aprobar│
│  🔴    | 2025-12-28  | 2025-12-31 |Finali│
└────────────────────────────────────────────┘
```

**Indicadores de estado:**

- 🔴 **Rojo (Terminado)** - Fecha límite vencida
- 🟡 **Amarillo (Hoy)** - Fecha límite es hoy
- 🟢 **Verde (En tiempo)** - Aún hay tiempo

**Funcionalidades:**

- Exportar a Excel: Descargar todas las tareas
- Exportar a PDF: Generar reporte en PDF
- Copiar: Copiar datos de la tabla
- Imprimir: Versión imprimible de las tareas
- Marcar como completada: Botón acción

---

### 2️⃣ Módulo de Ventas

**Acceso:** Menú lateral → Ventas

#### a) Remisiones

Gestión de remisiones de venta (notas de entrega).

**Subrutas:**

- **Remisionar** - Crear nueva remisión
    - Seleccionar cliente
    - Agregar productos
    - Definir cantidades y precios
    - Guardar como remisión

- **Remisionar Lista Black** - Remisiones para clientes Black
- **Remisionar Lista Platinum** - Remisiones para clientes Premium
- **Ver Remisiones** - Historial completo
- **Buscar Remisión** - Búsqueda y filtrado
- **Ver Productos Remisión** - Detalles de artículos

#### b) Pedidos

Sistema de gestión de pedidos de clientes.

**Opciones:**

- **Nuevo Pedido** - Crear pedido de cliente
- **Estado de Pedidos** - Ver estado actual
- **Reporte de Pedidos** - Historial y análisis
- **Cancelar Pedido** - Anular pedidos
- **Remisionar Pedido** - Convertir a remisión
- **Ver Ubicación Cliente** - Mapa de ubicación

**Estados de Pedido:**
| Estado | Significado |
|--------|-------------|
| **Nuevo** | Pedido recién creado |
| **Procesado** | En preparación |
| **Despachado** | En tránsito |
| **Entregado** | Completado |
| **Cancelado** | Anulado |

#### c) Corte de Caja

Control de ingresos y egresos de efectivo.

**Funciones:**

- **Corte de Caja** - Realizar cierre de día
- **Validar Corte** - Verificar totales
- **Histórico** - Ver cortes anteriores
- **Generar Reporte Individual** - Reporte por vendedor

**Información mostrada:**

- Monto inicial de caja
- Transacciones del día
- Monto final calculado
- Diferencias (si las hay)
- Fecha y vendedor responsable

---

### 3️⃣ Módulo de Inventario

**Acceso:** Menú lateral → Inventario

#### a) Gestión de Almacenes

- **Multi-Almacén** - Ver todos los almacenes
- **Alta Almacén** - Crear nuevo almacén
- **Baja Almacén** - Eliminar almacén
- **Edición Almacén** - Modificar datos

#### b) Gestión de Productos

**Operaciones:**

- **Alta Producto** - Crear nuevo producto
- **Baja Producto** - Dar de baja
- **Edición Producto** - Modificar información
- **Multi-Alta** - Importar múltiples productos

**Información por producto:**

- Nombre y descripción
- Código/SKU
- Categoría y marca
- Precio de costo
- Stock por almacén
- Unidad de medida

#### c) Movimientos de Inventario

**Tipos de movimientos:**

| Movimiento   | Descripción                |
| ------------ | -------------------------- |
| **Entrada**  | Ingreso de mercancía       |
| **Salida**   | Despacho a cliente         |
| **Traspaso** | Movimiento entre almacenes |
| **Compra**   | Adquisición a proveedor    |
| **Merma**    | Pérdida/daño               |

**Para cada tipo:**

- Crear movimiento
- Ver histórico
- Generar reporte
- Exportar datos

---

### 4️⃣ Módulo de Clientes

**Acceso:** Menú lateral → Clientes

#### Gestión de Clientes

- **Lista de Clientes** - Ver todos
- **Alta Cliente** - Registrar nuevo cliente
- **Baja Cliente** - Desactivar cliente
- **Edición Cliente** - Actualizar datos
- **Ver Dirección** - Consultar ubicación

**Datos de Cliente:**

```
┌──────────────────────────┐
│ 👤 Información Cliente   │
├──────────────────────────┤
│ Nombre                   │
│ RFC/Cédula               │
│ Teléfono                 │
│ Email                    │
│ Dirección                │
│ Ciudad/Estado            │
│ Tipo de cliente:         │
│   • Regular              │
│   • Platinum (premium)  │
└──────────────────────────┘
```

---

### 5️⃣ Módulo de Inventario Avanzado

**Acceso:** Menú lateral → Inventario

#### Gestión de Precios

- **Lista de Precios** - Ver precios activos
- **Alta Precio** - Crear nueva tarifa
- **Baja Precio** - Desactivar precio
- **Edición Precio** - Actualizar tarifa

**Tipos de Precio:**

- Precio base
- Precio cliente Black
- Precio cliente Platinum
- Precio especial por volumen

#### Gestión de Marcas

- **Lista Marcas** - Marcas disponibles
- **Alta Marca** - Agregar marca nueva
- **Baja Marca** - Eliminar marca
- **Edición Marca** - Modificar datos

#### Gestión de Categorías

- **Lista Categorías** - Categorías de productos
- **Alta Categoría** - Crear categoría
- **Baja Categoría** - Eliminar categoría
- **Edición Categoría** - Modificar

---

### 6️⃣ Módulo de Compras

**Acceso:** Menú lateral → Compras

#### Gestión de Compras a Proveedores

- **Nueva Compra** - Crear orden de compra
- **Baja Compra** - Cancelar compra
- **Edición Compra** - Modificar compra

**Información de Compra:**

- Proveedor
- Productos ordenados
- Cantidades
- Precios unitarios
- Fecha de entrega esperada
- Total compra
- Condiciones de pago

---

### 7️⃣ Módulo de Proveedores

**Acceso:** Menú lateral → Proveedores

#### Gestión de Proveedores

- **Lista Proveedores** - Todos los proveedores
- **Alta Proveedor** - Registrar nuevo
- **Baja Proveedor** - Desactivar
- **Edición Proveedor** - Actualizar datos

**Datos de Proveedor:**

- Razón social
- RFC
- Teléfono/Email
- Dirección
- Contacto principal
- Términos de pago
- Calificación

---

### 8️⃣ Módulo de Asistencias

**Acceso:** Menú lateral → Asistencias

#### a) Control de Asistencia

- **Registro Entrada** - Marcar entrada al trabajo
- **Registro Salida** - Marcar salida
- **Asistencia Personal** - Ver historial individual
- **Asistencia General** - Reporte de todo el equipo

#### b) Calendario y Vacaciones

- **Calendario** - Vista mensual de asistencias
- **Vacaciones** - Solicitar y gestionar
- **Incidencias** - Faltas, retardos, otros

**Indicadores de Incidencia:**

- 🟢 Presente
- 🔴 Falta
- 🟡 Retardo
- 🔵 Vacación
- ⚪ Justificado

#### c) Reportes

- **Reporte Asistencia Personal** - Por empleado
- **Gráficos Asistencias** - Visualización de datos

---

### 9️⃣ Módulo de Vendedores

**Acceso:** Menú lateral → Vendedores

#### Gestión de Vendedores

- **Lista Vendedores** - Equipo de ventas
- **Alta Vendedor** - Registrar nuevo vendedor
- **Baja Vendedor** - Desactivar
- **Edición Vendedor** - Actualizar información

**Datos de Vendedor:**

- Nombre completo
- Teléfono
- Email
- Comisión (%)
- Almacén asignado
- Estado (activo/inactivo)

---

### 🔟 Módulo de Cuentas por Cobrar (CxC)

**Acceso:** Menú lateral → Cuentas

#### Gestión de CxC

- **Crear CxC** - Registrar deuda de cliente
- **Abono CxC** - Registrar pago
- **Reporte CxC** - Ver deudas pendientes

**Información de Deuda:**

- Cliente
- Monto adeudado
- Fecha de vencimiento
- Interés acumulado
- Historial de pagos
- Estado (pendiente/pagada)

---

### 1️⃣1️⃣ Módulo de Reportes

**Acceso:** Menú lateral → Reportes

#### Reportes Disponibles

| Reporte                   | Contenido                 |
| ------------------------- | ------------------------- |
| **Imagen de Almacén**     | Stock actual por producto |
| **Movimientos Compras**   | Historial de compras      |
| **Movimientos Traspasos** | Traslados entre almacenes |
| **Movimientos Mermas**    | Pérdidas y daños          |
| **Movimientos Entradas**  | Ingresos registrados      |
| **Movimientos Salidas**   | Despachos registrados     |
| **Remisiones**            | Detalle de ventas         |
| **Lista de Precios**      | Catálogo de tarifas       |
| **Existencias y Costos**  | Valuación de inventario   |
| **Lista de Clientes**     | Directorio completo       |
| **Compras de Clientes**   | Historial por cliente     |
| **Lista Proveedores**     | Directorio de proveedores |
| **Histórico Inventario**  | Movimientos históricos    |
| **Corte de Caja**         | Ingresos por periodo      |
| **Resumen Ventas**        | Consolidado de ventas     |
| **Ventas por Cliente**    | Análisis por cliente      |
| **Ventas por Producto**   | Análisis por artículo     |
| **Ventas por Vendedor**   | Comisiones y desempeño    |

#### Exportación de Reportes

Todos los reportes permiten:

- 📊 **Excel** - Descarga para análisis
- 📄 **PDF** - Impresión profesional
- 🖨️ **Imprimir** - Salida directa
- 📋 **Copiar** - Copiar al portapapeles

---

### 1️⃣2️⃣ Módulo de Tareas

**Acceso:** Menú lateral → Tareas

#### Gestión de Tareas

- **Nueva Tarea** - Crear tarea y asignar
- **Tareas Delegadas** - Ver tareas asignadas a otros
- **Marcar Completada** - Actualizar estado

**Información de Tarea:**

- Asunto
- Descripción detallada
- Fecha inicio
- Fecha límite
- Asignado a (usuario)
- Prioridad
- Estado (pendiente/completada)

---

### 1️⃣3️⃣ Módulo de Usuarios

**Acceso:** Menú lateral → Configuración → Usuarios

#### Gestión de Usuarios

- **Lista Usuarios** - Todos los usuarios del sistema
- **Crear Usuario** - Nuevo usuario/empleado
- **Editar Usuario** - Modificar datos
- **Eliminar Usuario** - Desactivar cuenta

**Datos de Usuario:**

- Nombre completo
- Email (único)
- Teléfono
- Rol (Admin/Vendedor/Gerente/etc)
- Permisos asignados
- Estado (activo/inactivo)

---

### 1️⃣4️⃣ Administración de Banners

**Acceso:** Menú lateral → Configuración → Editar Banners

#### Actualización de Banners de Inicio

**Funcionalidad:**
Subir imágenes para el carrusel de la página pública.

**Especificaciones:**

- Cantidad: 6 banners
- Dimensiones: 1600 × 697 píxeles (exactas)
- Formato: JPG o JPEG
- Tamaño máximo: 2 MB cada uno

**Proceso:**

```
1. Acceder a Editar Banners
2. Para cada banner:
   a) Hacer clic en "Seleccionar archivo"
   b) Validar que sea JPG/JPEG
   c) Validar tamaño (máximo 2 MB)
   d) Validar dimensiones (1600×697)
3. Hacer clic en "Guardar"
4. El sistema actualiza automáticamente la página pública
```

---

## Roles y Permisos

### Sistema de Roles

PROGYMS utiliza un sistema de roles para controlar qué puede hacer cada usuario. El rol se asigna en la creación del usuario y determina las funcionalidades disponibles.

### Tipos de Roles

#### 1️⃣ Administrador (Admin)

**Permisos completos:**

- ✅ Acceso a todo el sistema
- ✅ Crear/editar/eliminar usuarios
- ✅ Editar banners públicos
- ✅ Gestionar proveedores
- ✅ Gestionar empleados
- ✅ Ver todos los reportes
- ✅ Configuración del sistema
- ✅ Gestionar asistencias

**Típico:** Dueño, gerente general

#### 2️⃣ Gerente de Ventas

**Permisos:**

- ✅ Crear remisiones y pedidos
- ✅ Ver clientes
- ✅ Consultar precios
- ✅ Generar corte de caja
- ✅ Ver reportes de ventas
- ✅ Gestionar vendedores
- ✅ CxC (Cuentas por cobrar)
- ❌ No puede gestionar inventario completo
- ❌ No puede crear usuarios

**Típico:** Jefe de ventas

#### 3️⃣ Vendedor

**Permisos:**

- ✅ Crear remisiones
- ✅ Ver catálogo de productos
- ✅ Ver clientes
- ✅ Marcar entrada/salida
- ❌ No puede cambiar precios
- ❌ No puede ver CxC
- ❌ No puede crear pedidos
- ❌ No puede ver otros vendedores

**Típico:** Personal de tienda

#### 4️⃣ Almacenero

**Permisos:**

- ✅ Gestionar inventario
- ✅ Crear movimientos
- ✅ Ver productos
- ✅ Traspasos entre almacenes
- ✅ Reportes de inventario
- ❌ No puede crear clientes
- ❌ No puede ver precios completos
- ❌ No puede crear usuarios

**Típico:** Personal de almacén

#### 5️⃣ Contador/Administrador de CxC

**Permisos:**

- ✅ Gestionar CxC
- ✅ Ver reportes financieros
- ✅ Ver movimientos de caja
- ✅ Aprobar pagos
- ❌ No puede crear productos
- ❌ No puede crear pedidos
- ❌ No puede editar usuarios

**Típico:** Contador, administrador financiero

### Solicitud de Cambio de Rol

Si requieres cambio de permisos:

```
1. Contacta al administrador del sistema
2. Especifica qué permisos necesitas
3. El admin evaluará la solicitud
4. Se confirmará por email
5. Los cambios se aplican inmediatamente
```

---

## Iniciar Sesión

### Propósito

Acceder a funcionalidades y servicios personalizados exclusivos para usuarios registrados.

### Acceso

```
Clic en "Iniciar Sesión" en el menú superior
O directamente en: https://progyms.com/logininit
```

### Formulario de Acceso

#### 1️⃣ Campos Requeridos

```
┌─────────────────────────────────────┐
│      ACCEDE A TU CUENTA             │
├─────────────────────────────────────┤
│ Correo Electrónico:                 │
│ ┌─────────────────────────────────┐ │
│ │ correo@ejemplo.com              │ │
│ └─────────────────────────────────┘ │
│                                     │
│ Contraseña:                         │
│ ┌─────────────────────────────────┐ │
│ │ ••••••••••••                    │ │
│ └─────────────────────────────────┘ │
│                                     │
│         [INGRESAR]                  │
└─────────────────────────────────────┘
```

#### 2️⃣ Requisitos

| Campo          | Validación                                     |
| -------------- | ---------------------------------------------- |
| **Correo**     | Debe ser un email válido (ejemplo@dominio.com) |
| **Contraseña** | Mínimo 8 caracteres, alfanumérica              |

#### 3️⃣ Proceso de Acceso

**Paso 1:** Ingresa tu correo electrónico registrado  
**Paso 2:** Ingresa tu contraseña  
**Paso 3:** Haz clic en "INGRESAR"  
**Paso 4:** Si los datos son correctos, accederás a tu dashboard

#### 4️⃣ Mensajes de Error

| Error                                 | Significado            | Solución                                |
| ------------------------------------- | ---------------------- | --------------------------------------- |
| **"Correo o contraseña incorrectos"** | Credenciales inválidas | Verifica mayúsculas y espacios          |
| **"Este correo no existe"**           | Usuario no registrado  | Crea una nueva cuenta o usa otro correo |
| **"Contraseña incorrecta"**           | Contraseña errónea     | Recupera tu contraseña                  |

#### 5️⃣ Recuperar Contraseña

Si olvidas tu contraseña:

```
1. En la página de login, busca "¿Olvidaste tu contraseña?"
2. Ingresa tu correo electrónico
3. Recibirás un enlace de recuperación por email
4. Haz clic en el enlace (válido por 24 horas)
5. Crea una nueva contraseña segura
6. Intenta acceder con tus nuevas credenciales
```

#### 6️⃣ Medidas de Seguridad

- 🔒 Las contraseñas se almacenan encriptadas
- 📧 Confirmación por email para cuentas nuevas
- ⏱️ Cierre de sesión automático después de 30 minutos de inactividad
- 🚫 Intentos limitados de login (máximo 5 intentos)

---

## Solución de Problemas

### Problemas Comunes y Soluciones

#### 1️⃣ La página no carga correctamente

**Síntomas:**

- Contenido desalineado
- Imágenes no se muestran
- Botones no funcionan

**Soluciones:**

```
a) Limpia caché del navegador
   → Ctrl+Shift+Delete (Chrome/Firefox) o Cmd+Shift+Delete (Mac)

b) Recarga la página
   → F5 o Ctrl+R

c) Intenta con otro navegador
   → Chrome, Firefox, Safari o Edge

d) Desactiva extensiones del navegador
   → Modo incógnito/privado para probar

e) Verifica tu conexión a internet
   → Prueba con otra red WiFi o datos móviles
```

#### 2️⃣ El carrusel de banners no funciona

**Síntomas:**

- Imágenes estáticas sin rotación
- Puntos de navegación sin respuesta

**Soluciones:**

```
a) Espera a que carguen completamente las imágenes

b) Recarga la página (F5)

c) Verifica que JavaScript esté habilitado
   → En navegador: Configuración → Privacidad → JavaScript

d) Borra cookies
   → Configuración → Historial → Eliminar datos de navegación
```

#### 3️⃣ El botón de WhatsApp no abre

**Síntomas:**

- Clic en el botón no abre nada
- Modal no se muestra
- Redireccionamiento a página en blanco

**Soluciones:**

```
a) Verifica tener WhatsApp Web en tu navegador
   → Abre web.whatsapp.com

b) Intenta desde la aplicación móvil
   → Descargar WhatsApp desde la tienda

c) Verifica conexión de internet

d) En móvil, asegúrate tener WhatsApp instalado
   → Descargar desde App Store o Google Play

e) Limpia caché de la aplicación
   → Configuración → Aplicaciones → WhatsApp → Almacenamiento
```

#### 4️⃣ Los filtros de productos no funcionan

**Síntomas:**

- Seleccionar filtro no cambia resultados
- Productos siguen siendo los mismos
- Página se bloquea

**Soluciones:**

```
a) Recarga la página de productos

b) Reinicia la sesión
   → Cierra sesión → Borra cookies → Accede nuevamente

c) Usa navegador diferente

d) Deshabilita bloqueadores de publicidad
   → Pueden interferir con JavaScript

e) Intenta con menos filtros simultáneamente
   → Aplica un filtro a la vez
```

#### 5️⃣ No puedo iniciar sesión

**Síntomas:**

- Error al ingresar credenciales
- Página no responde
- Sesión se cierra automáticamente

**Soluciones:**

```
a) Verifica que escribas correctamente tu email y contraseña
   → Sin espacios al inicio/final
   → Presta atención a mayúsculas

b) Recupera tu contraseña
   → Clic en "Olvidé mi contraseña"
   → Sigue las instrucciones en tu email

c) Borra cookies del navegador
   → Esto puede resolver problemas de sesión

d) Intenta desde otro dispositivo

e) Contacta a soporte si el problema persiste
   → Usa botón flotante de WhatsApp
```

#### 6️⃣ Las imágenes de productos no cargan

**Síntomas:**

- Icono de imagen rota
- Espacios en blanco donde debería haber imágenes
- "No image" en lugar de foto

**Soluciones:**

```
a) Espera a que cargue completamente la página

b) Recarga la página
   → Presiona F5

c) Verifica tu velocidad de conexión
   → Prueba con WiFi más rápida o conexión de datos

d) Desactiva extensiones de bloqueo de contenido
   → AdBlock, uBlock, etc.

e) Borra caché de imágenes
   → Configuración → Historial → Borrar datos de navegación
```

#### 7️⃣ El formulario de contacto no se envía

**Síntomas:**

- Botón "Enviar" no responde
- Mensaje de error al enviar
- Página se recarga sin guardar datos

**Soluciones:**

```
a) Verifica que todos los campos estén completos

b) Asegúrate de tener conexión a internet

c) Recarga la página

d) Intenta desde otro navegador

e) Usa directamente los botones de WhatsApp
   → Más confiable que formularios
```

---

## Glosario

### Términos Técnicos

| Término              | Definición                                                                      |
| -------------------- | ------------------------------------------------------------------------------- |
| **Cache**            | Almacenamiento temporal de datos en tu navegador para cargar páginas más rápido |
| **Cookies**          | Pequeños archivos que guardan información sobre tu navegación                   |
| **SSL/Encriptación** | Protección de datos sensibles mediante códigos seguros                          |
| **Responsive**       | Diseño que se adapta a diferentes tamaños de pantalla                           |
| **Modal**            | Ventana emergente que se superpone al contenido principal                       |
| **Hover**            | Efecto visual que ocurre al pasar el ratón sobre un elemento                    |
| **Zoom**             | Ampliación o reducción de contenido                                             |
| **Filtros**          | Herramientas para refinar búsquedas según criterios específicos                 |

### Términos de PROGYMS

| Término                          | Definición                                                       |
| -------------------------------- | ---------------------------------------------------------------- |
| **Suplemento**                   | Producto nutritivo que complementa la alimentación regular       |
| **Proteína**                     | Macronutriente esencial para crecimiento muscular y recuperación |
| **Creatina**                     | Suplemento que mejora fuerza, potencia y recuperación            |
| **Pre-entrenador (Pre-workout)** | Bebida para mejorar energía y concentración antes de ejercitar   |
| **BCAA**                         | Aminoácidos de cadena ramificada para recuperación muscular      |
| **Oferta**                       | Descuento temporal en el precio de un producto                   |
| **Stock**                        | Cantidad disponible de un producto                               |
| **Envío**                        | Traslado del producto desde la tienda hasta tu domicilio         |

### Categorías de Productos

| Categoría        | Ejemplos                                            |
| ---------------- | --------------------------------------------------- |
| **Proteínas**    | Whey protein, caseína, proteína vegetal             |
| **Aminoácidos**  | BCAA, EAA, glutamina                                |
| **Creatinas**    | Monohidrato, micronizada, creapure                  |
| **Pre-entrenos** | Bebidas energéticas, polvos estimulantes            |
| **Vitaminas**    | Multivitamínicos, vitamina D, magnesio              |
| **Energéticos**  | Bebidas tipo Monster, Red Bull, energéticos locales |

---

## Recomendaciones de UX

### Basadas en el Análisis del Código

#### ✅ Fortalezas del Diseño

1. **Interfaz Intuitiva**
    - Navegación clara y consistente
    - Menú responsivo bien implementado
    - Flujo de usuario lógico

2. **Responsive Design**
    - Se adapta perfectamente a móvil, tablet y desktop
    - Breakpoints bien definidos (576px, 768px, 992px)
    - Botón WhatsApp escalable según dispositivo

3. **Accesibilidad**
    - Botón flotante siempre visible
    - Contraste de colores adecuado
    - Textos legibles

4. **Rendimiento**
    - Carruseles optimizados (Owl Carousel)
    - Imágenes escaladas correctamente
    - JavaScript minificado

#### ⚠️ Puntos de Mejora

1. **Búsqueda Global**
    - **Problema:** No hay barra de búsqueda visible en el header
    - **Solución:** Agregar campo de búsqueda rápida en la navbar
    - **Beneficio:** Usuarios encontrarían productos 50% más rápido

2. **Historial de Productos Recientes**
    - **Problema:** No se guardan productos visitados recientemente
    - **Solución:** Implementar historial cliente-side con localStorage
    - **Beneficio:** Mejora experiencia de retorno de usuarios

3. **Carrito de Compras Visual**
    - **Problema:** No hay indicador de carrito en el header
    - **Solución:** Agregar contador de items en la navbar
    - **Beneficio:** Claridad sobre compras en progreso

4. **Comparador de Productos**
    - **Problema:** No se pueden comparar productos directamente
    - **Solución:** Agregar botón "Comparar" en tarjetas
    - **Beneficio:** Ayuda decisión de compra

5. **Reseñas de Clientes**
    - **Problema:** Estrellas pero sin reseñas de texto
    - **Solución:** Agregar sección de comentarios verificados
    - **Beneficio:** Genera confianza y social proof

6. **Chat en Vivo**
    - **Problema:** Solo WhatsApp, sin chat integrado en el sitio
    - **Solución:** Implementar chatbot o chat en tiempo real
    - **Beneficio:** Respuestas más rápidas y disponibilidad 24/7

7. **Indicadores de Precio Dinámico**
    - **Problema:** Precios múltiples pueden confundir
    - **Solución:** Mostrar ahorro explícito ("Ahorra $50")
    - **Beneficio:** Aumenta percepción de valor

8. **Perfeccionamiento de Filtros**
    - **Problema:** Filtros limitados a categoría y marca
    - **Solución:** Agregar: tamaño, sabor, formato, rango de precio
    - **Beneficio:** Búsqueda más precisa

#### 🎨 Recomendaciones de Diseño

1. **Mejora Visual del Banner**
    - Agregar degradados de fondo
    - Incluir call-to-action más prominente
    - Textos con mejor contraste

2. **Animaciones de Carga**
    - Skeleton loaders para productos
    - Transiciones suaves entre filtros
    - Indicadores de progreso

3. **Optimización Móvil**
    - Bottom navigation bar para navegación móvil
    - Botones más grandes (mínimo 48px)
    - Menú de categorías en hamburguesa mejorada

4. **Notificaciones**
    - Toast notifications para acciones (añadido al carrito, etc.)
    - Email de confirmación más detallado
    - SMS para estado de envío

#### 🔧 Recomendaciones Técnicas

1. **Lazy Loading**
    - Cargar imágenes bajo demanda
    - Beneficio: Página 40-50% más rápida

2. **Geolocalización**
    - Detectar sucursal más cercana automáticamente
    - Beneficio: Mejor experiencia localizada

3. **Wishlist/Favoritos**
    - Guardar productos favoritos
    - Sincronizar entre dispositivos
    - Beneficio: Retención de usuarios

4. **Análisis de Heatmap**
    - Saber dónde hacen clic los usuarios
    - Optimizar posición de elementos
    - Beneficio: Conversión optimizada

5. **Progressive Web App (PWA)**
    - Funcionar sin internet con caché
    - Instalable en pantalla de inicio
    - Beneficio: Acceso rápido y offline

#### 📊 Métricas de Seguimiento

Implementar Google Analytics para medir:

- % de usuarios que usan filtros
- Tiempo promedio en página
- Tasa de clics en WhatsApp
- Productos más vistos
- Páginas con mayor rebote

---

## Preguntas Frecuentes - Segunda Sección

### ¿Qué navegadores son compatibles?

**Respuesta:** PROGYMS funciona en:

- ✅ Chrome (versión 90+)
- ✅ Firefox (versión 88+)
- ✅ Safari (versión 14+)
- ✅ Edge (versión 90+)

Se recomienda usar la versión más reciente de tu navegador.

### ¿Necesito crear cuenta para ver productos?

**Respuesta:** No. Puedes explorar el catálogo sin registrarte. Solo necesitas cuenta si deseas:

- Realizar compras
- Guardar favoritos
- Ver historial de pedidos
- Acceder a ofertas personalizadas

### ¿Cuál es el horario de atención?

**Respuesta:** PROGYMS atiende por WhatsApp:

- Lunes a viernes: 9:00 AM - 8:00 PM
- Sábados: 10:00 AM - 6:00 PM
- Domingos: 10:00 AM - 4:00 PM

Los mensajes fuera de horario serán respondidos en el próximo turno.

### ¿Hacen envíos a otras ciudades?

**Respuesta:** Actualmente, los envíos son principalmente en la zona metropolitana de la Ciudad de México. Para envíos a otras ciudades, contacta directamente por WhatsApp.

### ¿Qué marcas venden?

**Respuesta:** Trabajamos con marcas reconocidas internacionalmente como:

- Optimum Nutrition (ON)
- Ronnie Coleman
- Dymatize
- MuscleTech
- Body Combat
- Y más marcas premium

---

## Contáctanos

Si tienes preguntas no respuestas en este manual:

**Usa el botón flotante de WhatsApp** (esquina inferior derecha)

O visita directamente: **https://progyms.com/contacto**

---

## Changelog (Historial de Cambios)

### Versión 1.0 - Inicial (2026)

- ✅ Creación del manual completo
- ✅ Documentación de todas las secciones
- ✅ Guía de solución de problemas
- ✅ Recomendaciones de UX/UI
- ✅ Glosario completo

---

**Documento preparado por:** Equipo Técnico PROGYMS  
**Fecha de creación:** 2026  
**Licencia:** Uso interno y público - PROGYMS®  
**Soporte:** Contacta por WhatsApp desde https://progyms.com

---

_Para reportar errores en este manual o sugerencias, contacta a través de nuestros canales de WhatsApp._
