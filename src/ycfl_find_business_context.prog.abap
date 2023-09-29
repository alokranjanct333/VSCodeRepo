************************************************************************
*  Confidential property of PepsiCo                                    *
*  All Rights Reserved                                                 *
************************************************************************
*      Program Name   :                                                *
*      TCode          :                                                *
*      Created By     :                                                *
*      Requested by   :                                                *
*      Created on     :                                                *
*      RICEF          :                                                *
*      PROJECT        :                                                *
*      FD Name        :                                                *
*      TR             :                                                *
*      Version        :                                                *
*      Description    :                                                *
*----------------------------------------------------------------------*
*  Modification Log:                                                   *
*----------------------------------------------------------------------*
* MOD#  | Date        |  Programmer  | CTS | Description               *
*----------------------------------------------------------------------*
*                                                                      *
*----------------------------------------------------------------------*

REPORT  YCFL_FIND_BUSINESS_CONTEXT.

TABLES:dd03l.

SELECT-OPTIONS   : s_tabnam FOR dd03l-tabname.


SELECT cfd_w_bus_ctxt~business_context,cfd_w_bus_ctxt~availability,cfd_w_bus_ctxt_t~description
  FROM cfd_w_bus_ctxt  INNER JOIN dd03l
  ON dd03l~precfield = cfd_w_bus_ctxt~persistence_include
  INNER JOIN cfd_w_bus_ctxt_t ON cfd_w_bus_ctxt~business_context = cfd_w_bus_ctxt_t~business_context
  INNER JOIN dd02l ON dd02l~tabname = dd03l~tabname
  WHERE "dd02l~tabclass = 'TRANSP'   AND
 dd03l~tabname IN @s_tabnam
   AND
cfd_w_bus_ctxt~persistence_include IS NOT INITIAL
  and cfd_w_bus_ctxt_t~LANGUAGE = @sy-langu
  INTO TABLE @DATA(lt_table_names).
