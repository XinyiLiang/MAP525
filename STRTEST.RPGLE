000100191126     H BNDDIR('LRNGSRV') DFTACTGRP(*no) ACTGRP(*caller)
000200130712      * This program uses "EZI" services which are provided to you as examples.
000300130605      * "EZI" services are shipped in your project library and may be used as you see fit.
000400130605     H BNDDIR('EZISERVICE')
000401191120     Fstoreitem1IF   E           K DISK    RENAME(storeitem1:strprod1)
000402191120     FStoreitem2IF   E           K DISK    RENAME(storeitem2:strprod2)
000403191120     FStoreitem3IF   E           K DISK    RENAME(storeitem3:strprod3)
000404191125     FStore     IF   E           K DISK    RENAME(store:storeR)
000405191120     Fcartitem  UF A E             DISK    RENAME(cartitem:cartitemR)
000406191125
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
005400191125
005401191124     DMyTableP4        DS                  LikeDs(EZI_QTable) Inz(*LikeDs)
005402191125     D P4_name         Ds                  LikeDS(EZI_Label) Inz(*LikeDS)
005403191125     D P4_Item_ID      Ds                  LikeDS(EZI_Label) Inz(*LikeDS)
005404191125     D P4_QUANTITY     Ds                  LikeDS(EZI_Label) Inz(*LikeDS)
005405191125     D P4_price        Ds                  LikeDS(EZI_Label) Inz(*LikeDS)
005406191125
005408191124     D P4              Ds                  LikeDS(EZI_QPanel) Inz(*LikeDS)
005500131008     D                 Ds
005600131008     D SendChangesOnly...
005700131008     D                                 N   Inz(False)
005800130903     D Handled         S               N
005801191125     D MessageBar      Ds                  LikeDS(EZI_QMessageBar) Inz(*LikeDS)
005802191126     DBtnBar_Clear     Ds                  LikeDs(EZI_QButtonBar) Inz(*LikeDs)
005803191124     D   Local         Ds
005804191124     D   MainLoopCount...
005805191124     D                               10I00 Inz(0)
005806191124     D   Row                         10I00 Inz(0)
005807191125     D   Rowi                        10I00 Inz(0)
005808191124     D   I                           10I00 Inz(0)
005809191124     D   ClickedRowNumber...
005810191124     D                               10i00
005811191124     D   ClickedRowID               256A   Varying
005812191125      * Other local variables
005813191125
005818191126     D TOTALCOST       s              9S02 inz(0)
005900120524      * Standard form view handler parameter list declaration
006000120524      /INCLUDE SOURCEDEMO,STDPARAMS
006100120524      * Use free format coding style
006200120524      /free
006300130716
006400130828        // Loop until this program should not handle the request
006500130716
006600130716        DoU (RequestPROGRAM <> ProgramINFO.Name);
006601191125
006704191125           SendChangesOnly = TRUE;
006705191125
007000191125        If ( EZI_HandleRequestACTION( RequestACTION:RequestPROGRAM
007001191125                               : SavedSTATE:SystemINFO:ProgramINFO) = False );
007200191125
007300191124          //  Handle the request
007400191125           Select;
007401191125              when (RequestACTION = 'CANCELADD1');
007402191125                 Exsr Setup_ImageBars;
007403191125                 Exsr Define_P1;
007404191125                 SendChangesOnly = false;
007405191125              when (RequestACTION = 'CANCELADD2');
007406191125                 Exsr Setup_ImageBars;
007407191125                 Exsr Define_P2;
007408191125                 SendChangesOnly = false;
007409191125
007410191125              when (RequestACTION = 'CANCELADD3');
007411191125                 Exsr Setup_ImageBars;
007412191125                 Exsr Define_P3;
007413191125                 SendChangesOnly = false;
007414191126
007415191126              when (RequestACTION = 'CANCEL4');
007416191126                 Exsr Setup_ImageBars;
007417191126                 Exsr Define_P4;
007418191126                 SendChangesOnly = false;
007419191126
007420191126
008431191125             when (RequestACTION = 'TONEROWCLICK');
008432191125
008433191125              ClickedRowId =  EZI_QTable_GetCurrentRowID(MyTableP1);
008434191125
008437191125                     EZI_TwoButton_MessageBox( 'Add it to calculator?'     // Title
008438191125                       : 'Product Name: '+ %char(ClickedRowId)     // Message
008442191125                       : 'Add Now'                                // Button 1 caption
008443191125                       : 'ADDITEM1'                               // Button 1 event
008444191125                       : 'Cancel'                               // Button 2 caption
008445191125                       : 'CANCELADD1' );                        // Button 2 event/a
008446191125
008467191125                     SendChangesOnly = false;
008468191125
008469191125             when (RequestACTION = 'ADDITEM1');
008471191125               Rowi = 1;
008472191125              setll *start storeitem1;
008473191125              READ storeitem1;
008474191125               DOW (NOT %EOF ) ;
008475191125               if %TRIMR(name)=%CHAR(ClickedRowId);
008481191125                     write  cartitemR;
008482191125                  endif;
008483191125                  ROWi+=1;
008484191125                read storeitem1;
008485191125                enddo;
008486191125
008488191125                 Exsr Setup_ImageBars;
008489191125                 Exsr Define_P1;
008490191125                 SendChangesOnly = false;
008491191125
008492191125
008493191125
008494191125
008495191125              when (RequestACTION = 'TTWOROWCLICK');
008497191125                   ClickedRowId =  EZI_QTable_GetCurrentRowID(MyTableP2);
008498191125
008499191125                     EZI_TwoButton_MessageBox( 'Add it to calculator?'     // Title
008500191125                       : 'Product Name: '+ %char(ClickedRowId)     // Message
008501191125                       : 'Add Now'                                // Button 1 caption
008502191125                       : 'ADDITEM2'                               // Button 1 event
008503191125                       : 'Cancel'                               // Button 2 caption
008504191125                       : 'CANCELADD2' );                        // Button 2 event/a
008505191125
008506191125                     SendChangesOnly = false;
008507191125
008508191125             when (RequestACTION = 'ADDITEM2');
008509191125               Rowi = 1;
008510191125              setll *start storeitem2;
008511191125              READ storeitem2;
008512191125               DOW (NOT %EOF ) ;
008513191125               if %TRIMR(name)=%CHAR(ClickedRowId);
008514191125                     write  cartitemR;
008515191125                  endif;
008516191125                  ROWi+=1;
008517191125                read storeitem2;
008518191125                enddo;
008521191125                 Exsr Setup_ImageBars;
008522191125                 Exsr Define_P2;
008523191125                 SendChangesOnly = false;
008528191125
008529191125              when (RequestACTION = 'TTHREEROWCLICK');
008530191125                       ClickedRowId =  EZI_QTable_GetCurrentRowID(MyTableP3);
008531191125
008532191125                     EZI_TwoButton_MessageBox( 'Add it to calculator?'     // Title
008533191125                       : 'Product Name: '+ %char(ClickedRowId)     // Message
008534191125                       : 'Add Now'                                // Button 1 caption
008535191125                       : 'ADDITEM3'                               // Button 1 event
008536191125                       : 'Cancel'                               // Button 2 caption
008537191125                       : 'CANCELADD3' );                        // Button 2 event/a
008538191125
008539191125                     SendChangesOnly = false;
008540191125
008541191126
008554191126
008555191125             when (RequestACTION = 'ADDITEM3');
008556191125               Rowi = 1;
008557191125              setll *start storeitem3;
008558191125              READ storeitem3;
008559191125               DOW (NOT %EOF ) ;
008560191125               if %TRIMR(name)=%CHAR(ClickedRowId);
008561191125                     write  cartitemR;
008562191125                  endif;
008563191125                  ROWi+=1;
008564191125                read storeitem3;
008565191125                enddo;
008566191125                 Exsr Setup_ImageBars;
008567191125                 Exsr Define_P3;
008568191125                 SendChangesOnly = false;
008569191126
008570191126
008571191126
008572191126            when (RequestACTION = 'TFOURROWCLICK');
008573191126                  ClickedRowId =  EZI_QTable_GetCurrentRowID(MyTableP4);
008574191126                  ClickedRowNumber=EZI_QTable_GetCurrentRow(MyTableP4);
008575191126                     EZI_TwoButton_MessageBox( 'Delete it to calculator?'     // Title
008576191126                       : 'Product Name: '+ %char(ClickedRowId)
008578191126                       : 'Yes'                                // Button 1 caption
008579191126                       : 'DELETEITEM'                               // Button 1 event
008580191126                       : 'NO'                               // Button 2 caption
008581191126                       : 'CANCEL4' );                        // Button 2 event/a
008583191126                     SendChangesOnly = false;
008584191126
008585191126             when (RequestACTION = 'DELETEITEM');
008586191126               Rowi = 1;
008587191126              setll *start cartitem;
008588191126              READ cartitem;
008589191126               DOW (NOT %EOF ) ;
008590191126               if (ROWI)= (ClickedRowNumber-1);
008591191126                     DELETE  cartitemR;
008592191126                  endif;
008593191126                  ROWi+=1;
008594191126                read cartitem;
008595191126                enddo;
008596191126                 Exsr Setup_ImageBars;
008597191126                 Exsr Define_P4;
008598191126                 SendChangesOnly = false;
008599191126
008600191126              when (RequestACTION = 'CLEARCART');
008601191126
008602191126              setll *start cartitem;
008603191126              READ cartitem;
008604191126               DOW (NOT %EOF ) ;
008606191126                     DELETE  cartitemR;
008608191126
008609191126                read cartitem;
008610191126                enddo;
008611191126                 Exsr Setup_ImageBars;
008612191126                 Exsr Define_P4;
008613191126                 SendChangesOnly = false;
008614191126
008615191125            When (RequestACTION = 'REQUEST_P1') or (RequestACTION = 'DEFAULT');
008616191120               Exsr Setup_ImageBars;
008700131008               Exsr Define_P1;
008800191125               SendChangesOnly = false;
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
011201191125
011300191125         //  Exsr Setup_ImageBars;
011400191125               Exsr Define_P4;
011403191126
011500191124                 SendChangesOnly = False;
011600131008
011601191125
011602191125             When (RequestACTION = 'Store_Location');
011603191125               Exsr DefineMap;
011604191125                // SendChangesOnly = False;
011605191125
011700191125           EndSl;
011900191125        Endif;
011901191125
012100130716           ///O/// Send and recieve the form view
012200191125          LRNG_SendReceive(SendChangesOnly:RequestPROGRAM:RequestACTION);
012201191125
012202191125
012300191125           EZI_MessageBarClear(MessageBar);
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
018700191125           Exsr Reset_EZI_Panels;
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
020611191125
020612191119           MyTableP1.title='Products on Store 1';               // Title
020613191125           MyTableP1.onRowClicked = 'TOneRowClick';  // Signals when a row touched/clicked
020614191125
020615191119           MyTableP1.IDColumn = 1;                 // Column 1 (Name) identifies the row
020616191119
020617191119         //MyTableP1.verticallayout= true;
020618191119           Row = 1;
020619191119         EZI_QTable_Define(MyTableP1             //( remove the comment characters (//) and complete
020620191119                   : P1_name
020621191119                   : P1_Item_ID
020622191119                   : P1_QUANTITY
020623191119                   : P1_price
020624191119                   : p1_available
020625191119                   : P1_category);
020626191119
020627191119
020628191120         setll *START storeitem1;
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
023805191125
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
023818191125           MyTableP2.onRowClicked = 'TTwoRowClick';  // Signals when a row touched/clicked
023819191120           MyTableP2.IDColumn = 1;                 // Column 1 (Name) identifies the row
023820191120
023821191125         //MyTableP2.verticallayout= true;
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
023836191125
023837191120               row +=1;
023838191120               EZI_QTable_PutRow(MyTableP2
023839191120                                 :row
023840191120                                 :name
023841191120                                 :%char(ITEM_ID)
023842191120                                 :%char(QUANTITY)
023843191120                                 :%char(price)
023844191120                                 :%char(AVAILABLE)
023845191120                                 :CATEGORY);
023846191120             read  storeitem2;
023847191120          ENDDO;
023848191120
023849191120       EndSr;
023850191120
023851191120       ///E/// ----------------------------------------------------------------------
023852191120       ///E/// Set up panel P3 and its content
023853191120       ///E/// ----------------------------------------------------------------------
023854191120       Begsr Define_P3;
023855191120
023856191120         // ------------------------------
023857191120         // Define the items on panel "P3"
023858191120         // ------------------------------
023859191120
023860191120              P3_name.label = 'Product';
023861191120              P3_Item_ID.Label = 'ID';
023862191120              P3_QUANTITY.label = 'Quantity';
023863191120              P3_price.Label = 'Price';
023864191120              p3_available.Label = 'Available';
023865191120              P3_category.Label = 'Category';
023866191120
023867191120           MyTableP3.ParentGRow=1;           // The grid row in this form view is 2
023868191120           MyTableP3.ParentGCol=1;           // The grid column in this form view is 1
023869191120           MyTableP3.HighlightCurrentRow=true;   // Highlights the current row
023870191120           MyTableP3.HighlightCurrentRow=true;    // The address column is to fill up all spare spac
023871191120           MyTableP3.title='Products on Store 3';               // Title
023872191125           MyTableP3.onRowClicked = 'TthreeRowClick';  // Signals when a row touched/clicked
023873191120           MyTableP3.IDColumn = 1;                 // Column 1 (Name) identifies the row
023874191120
023875191125         //MyTableP3.verticallayout= true;
023876191120           Row = 1;
023877191120         EZI_QTable_Define(MyTableP3             //( remove the comment characters (//) and complete
023878191120                   : P3_name
023879191120                   : P3_Item_ID
023880191120                   : P3_QUANTITY
023881191120                   : P3_price
023882191120                   : p3_available
023883191120                   : P3_category);
023884191120
023885191120
023886191120         setll *START  storeitem3;
023887191125         read  storeitem3;
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
045401191125           //set up image bar seperately
045402191125            // Grid layout
045403191125          LRNG_SetProperties( '/Form.Grid.Col%1.Width:fill'
045404191126                                  : '/Form.Grid.Row%1.Height:35'
045406191126                                  : '/Form.Grid.Row%2.Height:Fill'
045407191126                                  : '/Form.Grid.Row%3.Height:95'
045408191126
045410191125                                );
045411191125           // The message bar on top
045412191126            MessageBar.ParentGRow = 1;
045413191126            MessageBar.ParentGCol = 1;
045414191126
045415191126            BtnBar_Clear.ParentGRow=1;
045416191126            BtnBar_Clear.ParentGCol=2;
045417191126
045418191125          // This image bar will spread across the bottom
045419191126          ImgBar_2.ParentGRow = 3;
045420191125          ImgBar_2.ParentGCol = 1;
045421191125          ImgBar_2.rows       = -1;
045422191126          ImgBar_2.cols       = -1;
045423191126
045424191125          EZI_QImageBar_Define(  ImgBar_2
045425191125                  : 'Store1'     : 'bank_32.png'   : 'Request_P1'
045426191125                  : 'Store2'     : 'bank_32.png'   : 'Request_P2'
045427191125                  : 'Store3'     : 'bank_32.png'   : 'Request_P3'
045428191125                  : 'Store Locator' :'binoculars_32.png' : 'Store_location'
045429191125                  : 'Calculator'   : 'calculator_32.png'   : 'Request_P4'
045430191125                 );
045431191126
045432191126
045433191126          BtnBar_Clear.ButtonWidth ='120';
045434191126          BtnBar_Clear.OverallStyle=2;
045435191126          BtnBar_Clear.RedButtonNumber = 1;
045436191126
045437191126            EZI_QButtonBar_Define( BtnBar_Clear
045438191126                 : 'Clear Cart'  : 'CLEARCART');
045439191126
045440191125          // Reset all panels and fields to default. Normally this is not required.
045441191125          Exsr Reset_EZI_Panels;
045442191124         // ---------------------------------------
045443191124         // Define panel "P2" placement in the grid
045444191124         // ---------------------------------------
045445191126
045446191126
045447191125              totalcost=0;
045448191125              P4_name.label = 'Product';
045449191125              P4_Item_ID.Label = 'ID';
045450191125              P4_QUANTITY.label = 'Quantity';
045451191125              P4_price.Label = 'Price';
045452191125
045453191126           MyTableP4.ParentGRow=2;           // The grid row in this form view is 2
045454191124           MyTableP4.ParentGCol=1;           // The grid column in this form view is 1
045455191126           mytablep4.cols=-1;
045456191126           MyTableP4.HighlightCurrentRow=true;   // Highlights the current row
045457191124           MyTableP4.HighlightCurrentRow=true;    // The address column is to fill up all spare spac
045458191126           MyTableP4.onRowClicked = 'TFOURROWCLICK';
045459191124           MyTableP4.title='Products in cart';               // Title
045460191124           MyTableP4.IDColumn = 1;                 // Column 1 (Name) identifies the row
045461191124
045462191124         //MyTableP1.verticallayout= true;
045463191124           Row = 1;
045464191124         EZI_QTable_Define(MyTableP4             //( remove the comment characters (//) and complete
045465191125                   : P4_name
045466191125                   : P4_Item_ID
045467191125                   : P4_QUANTITY
045468191125                   : P4_price
045469191125                   );
045470191125         setll *START  cartitem;
045471191125         read  cartitem;
045472191125         DOW (NOT %EOF);
045473191126               TOTALCOST= TOTALCOST + %dec(price:5:2);
045474191126
045475191125               row +=1;
045476191125               EZI_QTable_PutRow(MyTableP4
045477191125                                 :row
045478191125                                 :name
045479191125                                 :%char(ITEM_ID)
045480191125                                 :'1'
045481191125                                 :%char(price)
045482191125                                );
045483191125             read  cartitem;
045484191125          ENDDO;
045485191124
045486191126           EZI_MessageBarAdd(MessageBar
045487191126                         : 'Total cost: ' + %char(%dec(TOTALCOST:10:2)));
045488191126                EZI_MessageBarShow(MessageBar);
045489191125
045490191124       EndSr;
045491191124
045492191125
045493191125          Begsr DefineMap;
045494191125
045508191125       ENDSR;
045509191125
045510191124       Begsr Reset_EZI_Panels;
045511131008
045600131008         Reset P1;
045700131008         Reset P2;
045800131008         Reset P3;
045900131008         Reset P4;
046000191125
048500131008       EndSr;
048600131008
048601191125
048621191125
048700130606      /end-free
