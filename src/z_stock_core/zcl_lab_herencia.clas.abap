CLASS zcl_lab_herencia DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
ENDCLASS.

CLASS zcl_lab_herencia IMPLEMENTATION.

   METHOD if_oo_adt_classrun~main.
    TRY.
        " === PRUEBA 1: MATERIAL LÍQUIDO ===
        DATA(mo_quimico) = NEW zcl_material_liquido( iv_id = `MAT-LIQ-01` iv_desc = `Acido Sulfurico` ).
        mo_quimico->registrar_litros( iv_litros = '500.0' ).
        out->write( mo_quimico->mostrar_informacion( ) ).

        out->write( |--------------------------------------------------| ).

        " === PRUEBA 2: TU NUEVO MATERIAL A GRANEL ===
        " Instanciamos la nueva clase que acabas de crear
        DATA(mo_cemento) = NEW zcl_material_granel( iv_id = `MAT-GRA-05` iv_desc = `Cemento Gris` ).

        " Registramos 3500 kilos (debería calcular 3.5 pallets)
        mo_cemento->registrar_kilos( iv_kilos = '3500.0' ).

        " Imprimimos el resultado redefinido
        out->write( mo_cemento->mostrar_informacion( ) ).

      CATCH cx_root INTO DATA(lx_error).
        out->write( lx_error->get_text( ) ).
    ENDTRY.
  ENDMETHOD.


ENDCLASS.
