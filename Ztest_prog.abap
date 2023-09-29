*select data from mara and show in alv using object oriented programming
*create a class    
CLASS lcl_mara DEFINITION.
  PUBLIC SECTION.
    METHODS: get_data.
  PRIVATE SECTION.
    DATA: lt_mara TYPE TABLE OF mara.

ENDCLASS.

*implement the class
CLASS lcl_mara IMPLEMENTATION.
  METHOD get_data.
    SELECT * FROM mara INTO TABLE lt_mara.
  ENDMETHOD.
ENDCLASS.

*create a class

CLASS lcl_alv DEFINITION.
  PUBLIC SECTION.
    METHODS: display_alv.
  PRIVATE SECTION.
    DATA: lt_mara TYPE TABLE OF mara.
    DATA: lr_mara TYPE REF TO lcl_mara.
    DATA: lr_alv TYPE REF TO cl_salv_table.
ENDCLASS.

*implement the class


CLASS lcl_alv IMPLEMENTATION.
  METHOD display_alv.
    CREATE OBJECT lr_mara.
    lr_mara->get_data( ).
    lt_mara = lr_mara->lt_mara.
    CREATE OBJECT lr_alv
      EXPORTING
        r_container = cl_gui_container=>screen0.
    lr_alv->set_table_for_first_display(
      EXPORTING
        is_layout = VALUE #( zebrastripes = abap_true )
      CHANGING
        it_outtab = lt_mara ).
  ENDMETHOD.
ENDCLASS.

*create a class

CLASS lcl_event DEFINITION.
  PUBLIC SECTION.
    METHODS: handle_event FOR EVENT fcode OF cl_gui_alv_grid
      IMPORTING e_salv_object.
  PRIVATE SECTION.
    DATA: lr_alv TYPE REF TO cl_salv_table.
ENDCLASS.

*implement the class

CLASS lcl_event IMPLEMENTATION.
  METHOD handle_event.
    CASE e_salv_object->id.
      WHEN 'SALV_TABLE'.
        lr_alv ?= e_salv_object.
        lr_alv->display_settings( ).
    ENDCASE.
  ENDMETHOD.

ENDCLASS.

*create a class

CLASS lcl_container DEFINITION.
  PUBLIC SECTION.
    METHODS: display_container.
  PRIVATE SECTION.
    DATA: lr_alv TYPE REF TO cl_salv_table.
    DATA: lr_event TYPE REF TO lcl_event.
    DATA: lr_container TYPE REF TO cl_gui_custom_container.

ENDCLASS.

*implement the class

CLASS lcl_container IMPLEMENTATION.
  METHOD display_container.
    CREATE OBJECT lr_container
      EXPORTING
        container_name = 'CONTAINER'.
    CREATE OBJECT lr_alv
      EXPORTING
        r_container = lr_container.
    CREATE OBJECT lr_event.
    SET HANDLER lr_event->handle_event FOR lr_alv.
    lr_alv->set_table_for_first_display(
      EXPORTING
        is_layout = VALUE #( zebrastripes = abap_true )
      CHANGING
        it_outtab = lt_mara ).
  ENDMETHOD.

ENDCLASS.

*now fecth data from mara and display in alv

START-OF-SELECTION.
  DATA: lr_container TYPE REF TO lcl_container.
  CREATE OBJECT lr_container.
  lr_container->display_container( ).

*end of the program









