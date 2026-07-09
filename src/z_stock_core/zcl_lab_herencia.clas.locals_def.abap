" ====================================================================
" 1. CLASE PADRE (SUPERCLASE DE MATERIALES)
" ====================================================================
CLASS zcl_material_base DEFINITION CREATE PUBLIC.
  PUBLIC SECTION.
    DATA: mv_id          TYPE string,
          mv_descripcion TYPE string.

    METHODS:
      constructor
        IMPORTING iv_id TYPE string iv_desc TYPE string,
      mostrar_informacion
        RETURNING VALUE(rv_texto) TYPE string.

  PROTECTED SECTION.
    DATA mv_stock_actual TYPE decfloat34.
ENDCLASS.

CLASS zcl_material_base IMPLEMENTATION.
  METHOD constructor.
    mv_id          = iv_id.
    mv_descripcion = iv_desc.
    mv_stock_actual = '0.0'.
  ENDMETHOD.

  METHOD mostrar_informacion.
    rv_texto = |ID: { mv_id } | && | Descripcion: { mv_descripcion }|.
  ENDMETHOD.
ENDCLASS.


" ====================================================================
" 2. CLASE HIJA (SUBCLASE QUE HEREDA Y REDEFINE)
" ====================================================================
CLASS zcl_material_liquido DEFINITION INHERITING FROM zcl_material_base FINAL.
  PUBLIC SECTION.
    METHODS mostrar_informacion REDEFINITION.

    METHODS registrar_litros
      IMPORTING iv_litros TYPE decfloat34.
ENDCLASS.

CLASS zcl_material_liquido IMPLEMENTATION.
  METHOD mostrar_informacion.
    DATA(lv_info_padre) = super->mostrar_informacion( ).
    rv_texto = |[LIQUIDO] { lv_info_padre } | && | Stock actual: { mv_stock_actual } Litros|.
  ENDMETHOD.

  METHOD registrar_litros.
    mv_stock_actual = mv_stock_actual + iv_litros.
  ENDMETHOD.
ENDCLASS.

"===================================================================
"3. Clase hija ( Subclase que hereda y redefine )
"===================================================================
CLASS zcl_material_granel DEFINITION INHERITING FROM zcl_material_base FINAL.
  PUBLIC SECTION.
    METHODS mostrar_informacion REDEFINITION.

    METHODS registrar_kilos
      IMPORTING iv_kilos TYPE decfloat34.
ENDCLASS.

CLASS zcl_material_granel IMPLEMENTATION.
  METHOD mostrar_informacion.
    " 1. Traemos los datos comunes del padre
    DATA(lv_info_padre) = super->mostrar_informacion( ).

    " 2. Calculamos los pallets necesarios justo aquí antes de mostrarlos
    DATA(lv_nro_palets) = mv_stock_actual / '1000.0'.

    " 3. Armamos la cadena final con toda la información combinada
    rv_texto = |[GRANEL] { lv_info_padre } | &&

               |Stock actual: { mv_stock_actual } Kilos | &&
               |(Pallets necesarios: { lv_nro_palets })|.
  ENDMETHOD.

  METHOD registrar_kilos.
    " El registro solo suma los kilos, manteniendo el método limpio
    mv_stock_actual = mv_stock_actual + iv_kilos.
  ENDMETHOD.
ENDCLASS.


