# Control de Stock de Materia Prima - ABAP Cloud 🧬

## 🏢 Contexto de Negocio (Módulo MM - Gestión de Materiales)
En la cadena de suministro y la gestión de almacenes (MM), el control preciso del inventario físico es crítico para evitar paros de producción. Ciertos materiales requieren un seguimiento especializado según su estado físico (líquidos o a granel). Este proyecto simula un componente logístico para SAP S/4HANA que unifica los datos maestros comunes de los materiales, pero automatiza los cálculos de almacenamiento específicos (como la cubicación o la necesidad de pallets) según la naturaleza del artículo.

### 📊 Lógicas de Almacenamiento Implementadas
*   **Materiales Líquidos:** Registran el inventario en **Litros** y mantienen el control volumétrico del stock.
*   **Materiales a Granel:** Registran el inventario en **Kilos** y calculan en tiempo real la cantidad exacta de **Pallets necesarios** para su almacenamiento en el muelle (asumiendo una capacidad estándar de 1,000 kg por pallet).

---

## 🛠️ Arquitectura de Software (POO)
El sistema utiliza el principio de **Herencia y Polimorfismo** bajo el estándar moderno de **ABAP Cloud** para maximizar la reutilización de código y garantizar el mantenimiento aislado de las reglas de stock.

### 🧱 Estructura de Clases Utilizada
1.  **Superclase Base (`zcl_material_base`):** Clase padre que encapsula los atributos comunes (`ID`, `Descripción`) y el atributo protegido `mv_stock_actual`.
2.  **Subclase Líquidos (`zcl_material_liquido`):** Hereda de la base, añade el método transaccional `registrar_litros` y redefine (`REDEFINITION`) el informe para adaptarlo a unidades volumétricas.
3.  **Subclase Granel (`zcl_material_granel`):** Hereda de la base, añade el método transaccional `registrar_kilos` y contiene la lógica de negocio bajo demanda para calcular pallets en su método redefinido.

---

## 🚀 Demostración del Laboratorio de Pruebas (`ZCL_LAB_HERENCIA`)

El procesador imita el comportamiento dinámico de los reportes de inventario de SAP (ej. transacción MB52), donde una única llamada al método base genera salidas de negocio totalmente adaptadas:

```abap
" Escenario A: Procesamiento de Material Líquido
DATA(mo_quimico) = NEW zcl_material_liquido( iv_id = `MAT-LIQ-01` iv_desc = `Ácido Sulfúrico` ).
mo_quimico->registrar_litros( iv_litros = '500.0' ).
" Resultado: [LÍQUIDO] ID: MAT-LIQ-01 Descripción: Ácido Sulfúrico Stock actual: 500 Litros

" Escenario B: Procesamiento de Material a Granel con Cálculo de Pallets
DATA(mo_cemento) = NEW zcl_material_granel( iv_id = `MAT-GRA-05` iv_desc = `Cemento Gris` ).
mo_cemento->registrar_kilos( iv_kilos = '3500.0' ).
" Resultado: [GRANEL] ID: MAT-GRA-05 Descripción: Cemento Gris Stock actual: 3500 Kilos (Pallets necesarios: 3.5)
```

---

## 📦 Estructura del Repositorio
Para cumplir de forma estricta con el formato de empaquetado de **abapGit**, el código se ha segmentado de forma limpia dentro del directorio fuente:
*   `src/z_stock_core/zcl_lab_herencia.clas.abap` (Definición e Implementación Global)
*   `src/z_stock_core/zcl_lab_herencia.clas.locals_def.abap` (Arquitectura local de Subclases)

