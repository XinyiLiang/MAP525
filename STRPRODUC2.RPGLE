000100191124     H BNDDIR('LRNGSRV') DFTACTGRP(*no) ACTGRP(*caller)
000200130712      * This program uses "EZI" services which are provided to you as examples.
000300130605      * "EZI" services are shipped in your project library and may be used as you see fit.
000400130605     H BNDDIR('EZISERVICE')
000401191120     Fstoreitem1IF   E           K DISK    RENAME(storeitem1:strprod1)
000402191120     FStoreitem2IF   E           K DISK    RENAME(storeitem2:strprod2)
000403191120     FStoreitem3IF   E           K DISK    RENAME(storeitem3:strprod3)
000404191125     FStore     IF   E           K DISK    RENAME(store:storeR)
000405191120     Fcartitem  UF A E             DISK    RENAME(cartitem:cartitemR)
000500131004      *<<DES>>="EZI Image Bar" example in free form RPG
000600130820      *<<PGM>>=EXAM0111
000700131004      *<<KEY>>=111 dynamic forms reuse subprograms generic Image ezi
000800130828      *<<CRT>>=B
000900130712      *<<END>>
001000120629      // Locally scoped field definitions
001100120524      /INCLUDE LRNGSOURCE,LRNGCOMMON
001200120524      * Standard demonstration definitions and prototypes
001300120524      /INCLUDE SOURCEDEMO,DEMOCOMMON
001400130605      * Program uses "EZI" building block services - see your version of library LRNG_PROJ
001500130712      /INCLUDE QRPGLESRC,EZISERVICE
001600131004      * Define 3 EZI "Q" Image bars
001700130816      *
001800131004     D ImgBar_1        Ds                  LikeDS(EZI_QImageBar) Inz(*LikeDS)
001900131004     D ImgBar_2        Ds                  LikeDS(EZI_QImageBar) Inz(*LikeDS)
002000131004     D ImgBar_3        Ds                  LikeDS(EZI_QImageBar) Inz(*LikeDS)
002100131008      * Panel P1
002200131008     D P1              Ds                  LikeDS(EZI_QPanel) Inz(*LikeDS)
002300131008      * The items on panel P1 ...
002301191119     DMyTableP1        DS                  LikeDs(EZI_QTable) Inz(*LikeDs)
002302191119
002400191119     D P1_name         Ds                  LikeDS(EZI_Label) Inz(*LikeDS)
002500191119     D P1_Item_ID      Ds                  LikeDS(EZI_Label) Inz(*LikeDS)
002600191119     D P1_QUANTITY     Ds                  LikeDS(EZI_Label) Inz(*LikeDS)
002601191119     D P1_price        Ds                  LikeDS(EZI_Label) Inz(*LikeDS)
002602191119     D p1_available    Ds                  LikeDS(EZI_Label) Inz(*LikeDS)
002603191119     D P1_category     Ds                  LikeDS(EZI_Label) Inz(*LikeDS)
002700131008      * Panel P2
002800191120     D P2              Ds                  LikeDS(EZI_QPanel) Inz(*LikeDS)
002801191120      * The items on panel P2 ...
002802191120     DMyTableP2        DS                  LikeDs(EZI_QTable) Inz(*LikeDs)
002803191120     D P2_name         Ds                  LikeDS(EZI_Label) Inz(*LikeDS)
002804191120     D P2_Item_ID      Ds                  LikeDS(EZI_Label) Inz(*LikeDS)
002805191120     D P2_QUANTITY     Ds                  LikeDS(EZI_Label) Inz(*LikeDS)
002806191120     D P2_price        Ds                  LikeDS(EZI_Label) Inz(*LikeDS)
002807191120     D p2_available    Ds                  LikeDS(EZI_Label) Inz(*LikeDS)
002808191120     D P2_category     Ds                  LikeDS(EZI_Label) Inz(*LikeDS)
002809191120      * Panel P3
002810191120     D P3              Ds                  LikeDS(EZI_QPanel) Inz(*LikeDS)
002811191120      * The items on panel P3 ...
002812191120     DMyTableP3        DS                  LikeDs(EZI_QTable) Inz(*LikeDs)
002813191120     D P3_name         Ds                  LikeDS(EZI_Label) Inz(*LikeDS)
002814191120     D P3_Item_ID      Ds                  LikeDS(EZI_Label) Inz(*LikeDS)
002815191120     D P3_QUANTITY     Ds                  LikeDS(EZI_Label) Inz(*LikeDS)
002816191120     D P3_price        Ds                  LikeDS(EZI_Label) Inz(*LikeDS)
002817191120     D p3_available    Ds                  LikeDS(EZI_Label) Inz(*LikeDS)
002818191120     D P3_category     Ds                  LikeDS(EZI_Label) Inz(*LikeDS)
005000131008      * Panel P4
005400130715      * Local variables
005401191124     DMyTableP4        DS                  LikeDs(EZI_QTable) Inz(*LikeDs)
005402191124     D P4_name         Ds                  LikeDS(EZI_Label) Inz(*LikeDS)
005403191124     D P4_Item_ID      Ds                  LikeDS(EZI_Label) Inz(*LikeDS)
005404191124     D P4_QUANTITY     Ds                  LikeDS(EZI_Label) Inz(*LikeDS)
005405191124     D P4_price        Ds                  LikeDS(EZI_Label) Inz(*LikeDS)
005406191124     D p4_available    Ds                  LikeDS(EZI_Label) Inz(*LikeDS)
005407191124     D P4_category     Ds                  LikeDS(EZI_Label) Inz(*LikeDS)
005408191124     D P4              Ds                  LikeDS(EZI_QPanel) Inz(*LikeDS)
005500131008     D                 Ds
005600131008     D SendChangesOnly...
005700131008     D                                 N   Inz(False)
005800130903     D Handled         S               N
005801191125     D MessageBar      Ds                  LikeDS(EZI_QMessageBar) Inz(*LikeDS)
005802191124     D   Local         Ds
005803191124     D   MainLoopCount...
005804191124     D                               10I00 Inz(0)
005805191124     D   Row                         10I00 Inz(0)
005806191124     D   I                           10I00 Inz(0)
005807191124     D   ClickedRowNumber...
005808191124     D                               10i00
005809191124     D   ClickedRowID               256A   Varying
005900120524      * Standard form view handler parameter list declaration
006000120524      /INCLUDE SOURCEDEMO,STDPARAMS
006100120524      * Use free format coding style
006200120524      /free
006300130716
006400130828        // Loop until this program should not handle the request
006500130716
006600130716        DoU (RequestPROGRAM <> ProgramINFO.Name);
006700130716
006800191124          SendChangesOnly = True;
006900131008
007000131008         If ( EZI_HandleRequestACTION( RequestACTION:RequestPROGRAM
007100131008                               : SavedSTATE:SystemINFO:ProgramINFO) = False );
007200191120
007300191124          //  Handle the request
007400130716           Select;
007500191120
008200131009            // ---------------------------------------------------------------------------
008300131009            // Show the P1 panel - the request action is specified when defining the image
008400131009            // ---------------------------------------------------------------------------
008401191126              // Message
008405191125         // CLICKEDROWNUMBER=EZI_QTABLE_GETCURRENTROW(MYTABLEP1);
008406191125         // CLICKEDROWID=EZI_QTABLE_GETCURRENTROWID(MYTABLEP1);
008407191125         // Write CartItemR;
008413191124
008500191126            When (RequestACTION = 'REQUEST_P1');
008600191120               Exsr Setup_ImageBars;
008700131008               Exsr Define_P1;
008800191124                 SendChangesOnly = False;
008900130903
008901191120
009000131009            // --------------------------------------------------------------------------
009100131009            // Show the P2 panel - the request action is specified when defining the image
009200131009            // in the image bar.
009300131009            // --------------------------------------------------------------------------
009400131008            When (RequestACTION = 'REQUEST_P2');
009500191120             Exsr Setup_ImageBars;
009600131008               Exsr Define_P2;
009700191124                 SendChangesOnly = False;
009800131008
009900131008            // ----------------------------------------
010000131009            // Show the P3 panel - the request action is specified when defining the image
010100131009            // in the image bar. Also, initially (DEFAULT request)
010200131009            // Show this panel initially (DEFAULT request) too
010300131008            // ----------------------------------------
010400191119            When (RequestACTION = 'REQUEST_P3');
010500191120             Exsr Setup_ImageBars;
010600131008               Exsr Define_P3;
010700191124                 SendChangesOnly = False;
010800131008
010900131008            // ----------------------------------------
011000131009            // Show the P4 panel - the request action is specified when defining the image
011100131008            // ----------------------------------------
011200131008            When (RequestACTION = 'REQUEST_P4');
011300191120            // Exsr Setup_ImageBars;
011400131008               Exsr Define_P4;
011500191124                 SendChangesOnly = False;
011600131008
011601191125             When (RequestACTION = 'Store_Location');
011603191125               Exsr DefineMap;
011604191125                // SendChangesOnly = False;
011605191126
011606191126
011607191126                  when (RequestACTION = 'T1RowClick');
011608191126                      EZI_OK_MessageBox( 'Example 2'                                 // Title
011609191126                      : 'This is the EZI_OK_MessageBox which can +
011610191126                        be set up and displayed by one RPG operation.' );
011611191125
011700130716           EndSl;
011800130716
011900131008          Endif;
012000131008
012100130716           ///O/// Send and recieve the form view
012200131008           LRNG_SendReceive(SendChangesOnly:RequestPROGRAM:RequestACTION);
012300130606
012400130716        EndDo;
012500130716
012600130605        // Finished. Return control to driver.
012700130605        *InLR = True;
012800130605        Return;
012900130716
013000130828       ///E/// ======================================================================
013100131009       ///E/// Setup 2 Image bars.
013200130828       ///E/// ======================================================================
013300130816
013400131004        BegSr Setup_ImageBars;
013600131008          // Grid layout
013700191119          LRNG_SetProperties( '/Form.Grid.Col%1.Width:fill'
013900191119                                  : '/Form.Grid.Row%2.Height:95'
014000131011                                  : '/Form.Grid.Row%1.Height:Fill'
014100191120
017100191120                                );
017200131009          // This image bar will spread across the bottom
017300191119          ImgBar_2.ParentGRow = 2;
017400191119          ImgBar_2.ParentGCol = 1;
017500191119          ImgBar_2.rows       = -1;
017600131008
017700131008          EZI_QImageBar_Define(  ImgBar_2
017800191119                  : 'Store1'     : 'bank_32.png'   : 'Request_P1'
017900191119                  : 'Store2'     : 'bank_32.png'   : 'Request_P2'
018000191120                  : 'Store3'     : 'bank_32.png'   : 'Request_P3'
018001191125                  : 'Store Locator' :'binoculars_32.png' : 'Store_location'
018200191119                  : 'Calculator'   : 'calculator_32.png'   : 'Request_P4'
018300191119                 );
018500131004
018600131008          // Reset all panels and fields to default. Normally this is not required.
018700131008          Exsr Reset_EZI_Panels;
018800131008
018900130816        EndSr;
019000131008
019100131008       ///E/// ----------------------------------------------------------------------
019200131008       ///E/// Define the EZI Quick panels
019300131008       ///E/// ----------------------------------------------------------------------
019400131008       Begsr Define_P1;
019500131008
019501191124
019600131009         // ---------------------------------------
019700131009         // Define panel "P1" placement in the grid
019800191120         // ---------------------------------------
020501191119
020600191119          // Define the 4 columns to be used in the table
020601191119              P1_name.label = 'Product';
020602191119              P1_Item_ID.Label = 'ID';
020603191119              P1_QUANTITY.label = 'Quantity';
020604191119              P1_price.Label = 'Price';
020605191119              p1_available.Label = 'Available';
020606191119              P1_category.Label = 'Category';
020607191119
020608191119           MyTableP1.ParentGRow=1;           // The grid row in this form view is 2
020609191119           MyTableP1.ParentGCol=1;           // The grid column in this form view is 1
020610191119           MyTableP1.HighlightCurrentRow=true;   // Highlights the current row
020611191119           MyTableP1.HighlightCurrentRow=true;    // The address column is to fill up all spare spac
020612191119           MyTableP1.title='Products on Store 1';               // Title
020613191120           MyTableP1.onRowClicked = 'T1RowClick';  // Signals when a row touched/clicked
020614191119           MyTableP1.IDColumn = 1;                 // Column 1 (Name) identifies the row
020615191119
020616191119         //MyTableP1.verticallayout= true;
020617191119           Row = 1;
020618191119         EZI_QTable_Define(MyTableP1             //( remove the comment characters (//) and complete
020619191119                   : P1_name
020620191119                   : P1_Item_ID
020621191119                   : P1_QUANTITY
020622191119                   : P1_price
020623191119                   : p1_available
020624191119                   : P1_category);
020625191119
020626191119
020627191120         setll *START storeitem1;
021100191120         read storeitem1;
021101191120
021102191119         DOW (NOT %EOF);
021103191119               row +=1;
021104191119               EZI_QTable_PutRow(MyTableP1
021105191119                                 :row
021106191119                                 :name
021107191120                                 :%char(ITEM_ID)
021108191120                                 :%char(QUANTITY)
021109191120                                 :%char(price)
021110191120                                 :%char(AVAILABLE)
021111191119                                 :CATEGORY);
021112191120             read storeitem1;
022400191120          ENDDO;
023300131008       EndSr;
023400131008
023500131008       ///E/// ----------------------------------------------------------------------
023600131008       ///E/// Define the EZI Quick panels
023700131008       ///E/// ----------------------------------------------------------------------
023800191120       Begsr Define_P2;
023801191120
023802191120         // ---------------------------------------
023803191120         // Define panel "P2" placement in the grid
023804191120         // ---------------------------------------
023805191120
023806191120              P2_name.label = 'Product';
023807191120              P2_Item_ID.Label = 'ID';
023808191120              P2_QUANTITY.label = 'Quantity';
023809191120              P2_price.Label = 'Price';
023810191120              p2_available.Label = 'Available';
023811191120              P2_category.Label = 'Category';
023812191120
023813191120           MyTableP2.ParentGRow=1;           // The grid row in this form view is 2
023814191120           MyTableP2.ParentGCol=1;           // The grid column in this form view is 1
023815191120           MyTableP2.HighlightCurrentRow=true;   // Highlights the current row
023816191120           MyTableP2.HighlightCurrentRow=true;    // The address column is to fill up all spare spac
023817191120           MyTableP2.title='Products on Store 2';               // Title
023818191120           MyTableP2.onRowClicked = 'T2RowClick';  // Signals when a row touched/clicked
023819191120           MyTableP2.IDColumn = 1;                 // Column 1 (Name) identifies the row
023820191120
023821191120         //MyTableP1.verticallayout= true;
023822191120           Row = 1;
023823191120         EZI_QTable_Define(MyTableP2             //( remove the comment characters (//) and complete
023824191120                   : P2_name
023825191120                   : P2_Item_ID
023826191120                   : P2_QUANTITY
023827191120                   : P2_price
023828191120                   : p2_available
023829191120                   : P2_category);
023830191120
023831191120
023832191120         setll *START  storeitem2;
023833191120         read  storeitem2;
023834191120
023835191120         DOW (NOT %EOF);
023836191120               row +=1;
023837191120               EZI_QTable_PutRow(MyTableP2
023838191120                                 :row
023839191120                                 :name
023840191120                                 :%char(ITEM_ID)
023841191120                                 :%char(QUANTITY)
023842191120                                 :%char(price)
023843191120                                 :%char(AVAILABLE)
023844191120                                 :CATEGORY);
023845191120             read  storeitem2;
023846191120          ENDDO;
023847191120
023848191120       EndSr;
023849191120
023850191120       ///E/// ----------------------------------------------------------------------
023851191120       ///E/// Set up panel P3 and its content
023852191120       ///E/// ----------------------------------------------------------------------
023853191120       Begsr Define_P3;
023854191120
023855191120         // ------------------------------
023856191120         // Define the items on panel "P3"
023857191120         // ------------------------------
023858191120
023859191120              P3_name.label = 'Product';
023860191120              P3_Item_ID.Label = 'ID';
023861191120              P3_QUANTITY.label = 'Quantity';
023862191120              P3_price.Label = 'Price';
023863191120              p3_available.Label = 'Available';
023864191120              P3_category.Label = 'Category';
023865191120
023866191120           MyTableP3.ParentGRow=1;           // The grid row in this form view is 2
023867191120           MyTableP3.ParentGCol=1;           // The grid column in this form view is 1
023868191120           MyTableP3.HighlightCurrentRow=true;   // Highlights the current row
023869191120           MyTableP3.HighlightCurrentRow=true;    // The address column is to fill up all spare spac
023870191120           MyTableP3.title='Products on Store 3';               // Title
023871191120           MyTableP3.onRowClicked = 'T3RowClick';  // Signals when a row touched/clicked
023872191120           MyTableP3.IDColumn = 1;                 // Column 1 (Name) identifies the row
023873191120
023874191120         //MyTableP1.verticallayout= true;
023875191120           Row = 1;
023876191120         EZI_QTable_Define(MyTableP3             //( remove the comment characters (//) and complete
023877191120                   : P3_name
023878191120                   : P3_Item_ID
023879191120                   : P3_QUANTITY
023880191120                   : P3_price
023881191120                   : p3_available
023882191120                   : P3_category);
023883191120
023884191120
023885191120         setll *START  storeitem3;
023886191120         read  storeitem3;
023887191120
023888191120         DOW (NOT %EOF);
023889191120               row +=1;
023890191120               EZI_QTable_PutRow(MyTableP3
023891191120                                 :row
023892191120                                 :name
023893191120                                 :%char(ITEM_ID)
023894191120                                 :%char(QUANTITY)
023895191120                                 :%char(price)
023896191120                                 :%char(AVAILABLE)
023897191120                                 :CATEGORY);
023898191120             read  storeitem3;
023899191120          ENDDO;
023900191120
023901191120       EndSr;
038300131008
038301191124
038400131008       ///E/// ----------------------------------------------------------------------
038500131009       ///E/// Set up panel P4 and its content
038600131008       ///E/// ----------------------------------------------------------------------
045100131008       ///O/// ----------------------------------------------------------------------
045200131008       ///O/// Reset all panels and field to defaults
045300131008       ///O/// ----------------------------------------------------------------------
045400191124         Begsr Define_P4;
045401191124
045402191124         // ---------------------------------------
045403191124         // Define panel "P2" placement in the grid
045404191124         // ---------------------------------------
045405191124
045406191124              P4_name.label = 'Product';
045407191124              P4_Item_ID.Label = 'ID';
045408191124              P4_QUANTITY.label = 'Quantity';
045409191124              P4_price.Label = 'Price';
045410191124              p4_available.Label = 'Available';
045411191124              P4_category.Label = 'Category';
045412191124
045413191124           MyTableP4.ParentGRow=1;           // The grid row in this form view is 2
045414191124           MyTableP4.ParentGCol=1;           // The grid column in this form view is 1
045415191124           MyTableP4.HighlightCurrentRow=true;   // Highlights the current row
045416191124           MyTableP4.HighlightCurrentRow=true;    // The address column is to fill up all spare spac
045417191124           MyTableP4.title='Products in cart';               // Title
045419191124           MyTableP4.IDColumn = 1;                 // Column 1 (Name) identifies the row
045420191124
045421191124         //MyTableP1.verticallayout= true;
045422191124           Row = 1;
045423191124         EZI_QTable_Define(MyTableP4             //( remove the comment characters (//) and complete
045424191124                   : P4_name
045425191124                   : P4_Item_ID
045426191124                   : P4_QUANTITY
045427191124                   : P4_price
045428191124                   : p4_available
045429191124                   : P4_category);
045430191124
045431191124
045432191124         setll *START  cartitem;
045433191124         read  cartitem;
045434191124
045435191124         DOW (NOT %EOF);
045436191124               row +=1;
045437191124               EZI_QTable_PutRow(MyTableP4
045438191124                                 :row
045439191124                                 :name
045440191124                                 :%char(ITEM_ID)
045441191124                                 :%char(QUANTITY)
045442191124                                 :%char(price)
045443191124                                 :%char(AVAILABLE)
045444191124                                 :CATEGORY);
045445191124             read  cartitem;
045446191124          ENDDO;
045447191124
045448191124       EndSr;
045449191124
045450191125
045451191125          Begsr DefineMap;
045452191125        //     If ( EZI_IsLargeDevice(SystemINFO) );
045453191125        //       LRNG_SetProperties( '/Form.Grid.Row%3.Height:Fill');
045454191125        //     Else;
045455191125         //       LRNG_SetProperties( '/Form.Grid.Row%3.Height:400');
045456191125        //     EndIf;
045457191125
045458191125               LRNG_Using('/Form.Fields.txtLocation');
045459191125        //         LRNG_SetProperties( 'Type : Label'
045460191125        //                           : 'Layout.Row : 2'
045461191125        //                           : 'Layout.Col : 1'
045462191125        //                           : 'Text : Store Location:'
045463191125        //                           : 'Font.Italic: Yes'
045464191125        //                           : 'Font.Size: 14' );
045465191125        //         LRNG_EndUsing();
045466191125
045467191125        //      LRNG_Using('/Form.Fields.Map');
045468191125        //         LRNG_SetProperties( 'Type : Map'
045469191125        //                           : 'Layout.Row : 3'
045470191125        //                           : 'Layout.Col : 1' );
045471191125        //        LRNG_AssignNumToProp(15 : 'Zoom');
045472191125        //             DOW (NOT %EOF);
045473191125        //        LRNG_Using('Location');
045474191125        //            LRNG_AssignStrToProp(%trim(Store00001)   : 'Street');
045475191125        //            LRNG_AssignStrToProp(%trim(CITY) : 'Locality');
045476191125        //            LRNG_AssignStrToProp(%trim(PROVINCE)     : 'Area');
045477191125        //            LRNG_AssignStrToProp(%trim(Zip)          : 'PostCode');
045478191125        //            LRNG_AssignStrToProp(%char(Store_Id)   : 'Text');
045479191125
045480191125        //          LRNG_EndUsing();
045481191125        //          read store;
045482191125        //          enddo;
045483191125        //      LRNG_EndUsing();
045484191125       ENDSR;
045485191125
045486191124       Begsr Reset_EZI_Panels;
045500131008
045600131008         Reset P1;
045700131008         Reset P2;
045800131008         Reset P3;
045900131008         Reset P4;
046000131008
046100191119        //Reset P1_NAME;
046200191119       // Reset P1_ITEM;
046300191119       //Reset P1_ShipTo;
046301191120      //RESET MYTABLEP1;
046400191120       //
046500191120       //  Reset P2_Name;
046600191120       //  Reset P2_Image;
046700191120       //  Reset P2_EMail;
046800191120       //  Reset P2_Date;
046900191120       //  Reset P2_Time;
047000191120       //  Reset P2_Check;
047100191120       //
047200191120       //  Reset P3_Name;
047300191120       //  Reset P3_Address;
047400191120       //  Reset P3_City;
047500191120       //  Reset P3_Zip;
047600191120       //  Reset P3_Phone;
047700191120       //  Reset P3_EMail;
047800191120       //  Reset P3_CLimit;
047900191120       //  Reset P3_CAvail;
048000191120       //  Reset P3_Photo;
048100191120       //  Reset P3_Authorize;
048200131008
048300191124      // Reset P4_Text;
048400131008
048500131008       EndSr;
048600131008
048700130606      /end-free
