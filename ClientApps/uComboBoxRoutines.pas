unit uComboBoxRoutines;

interface

uses SysUtils, Classes, StdCtrls, Windows, Messages;

type

TComboSearchThread = class;   // Forward declaration

TLoadItemsComboCallback = procedure(AText: string) of object;

//************************************************************************
//* TDynamicComboBoxHandler
//************************************************************************
TDynamicComboBoxHandler = class(TObject)
   protected
      FComboBox: TComboBox;
      //FPopulatingCombo: Boolean;
      FProcessingKeyPress: Boolean;
      FLastKeyIsArrowKey: Boolean;
      FForcedDroppedDown: Boolean;
      FComboSearchText: string;
      FComboSearchSelStart: Integer;
      FCurrentComboSearchThread: TComboSearchThread;
      FNextComboSearchThread: TComboSearchThread;

      FOnLoadItems: TLoadItemsComboCallback;
      FOnSelectItem: TNotifyEvent;

      FOldOnEnter: TNotifyEvent;
      FOldOnExit: TNotifyEvent;

      //procedure ComboClick(Sender: TObject); virtual;
      procedure ComboChange(Sender: TObject); virtual;
      procedure ComboChangeOnBackground(Sender: TObject); virtual;
      procedure ComboChangeOnBackgroundTerminate(Sender: TObject); virtual;
      procedure ComboDropDown(Sender: TObject); virtual;
      procedure ComboKeyPress(Sender: TObject; var Key: Char); virtual;
      procedure ComboKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState); virtual;
      procedure ComboEnter(Sender: TObject); virtual;
      procedure ComboExit(Sender: TObject); virtual;
      procedure ComboCloseUp(Sender: TObject); virtual;

      procedure PopulateComboAccordingToText; virtual;

      procedure DoLoadItems(AText: string); virtual;
      procedure DoSelectItem; virtual;
      procedure DoOldEnter; virtual;
      procedure DoOldExit; virtual;
   public
      constructor Create; virtual;
      procedure AssignToComboBox(AComboBox: TComboBox); virtual;

      property ComboBox: TComboBox read FComboBox;

      property OnLoadItems: TLoadItemsComboCallback read FOnLoadItems write FOnLoadItems;
      property OnSelectItem: TNotifyEvent read FOnSelectItem write FOnSelectItem;
end;

//************************************************************************
//* TComboSearchThread
//************************************************************************
TComboSearchThread = class(TThread)
  protected
     FComboHandler: TDynamicComboBoxHandler;
     FSelectionDone: Boolean;
  public
     property ComboHandler: TDynamicComboBoxHandler read FComboHandler write FComboHandler;
     property SelectionDone: Boolean read FSelectionDone write FSelectionDone;

     procedure Execute; override;
end;

TThreadHack = class(TThread);

procedure ClearComboItemsWithoutLosingText(AComboBox: TComboBox);

implementation

//************************************************************************
//* TDynamicComboBoxHandler.Create
//************************************************************************
constructor TDynamicComboBoxHandler.Create;
begin
   FComboBox:=nil;
   //FPopulatingCombo:=False;
   FProcessingKeyPress:=False;
   FLastKeyIsArrowKey:=False;
   FForcedDroppedDown:=False;
   FComboSearchText:='';
   FComboSearchSelStart:=0;
   FCurrentComboSearchThread:=nil;
   FNextComboSearchThread:=nil;
   FOnLoadItems:=nil;
   FOnSelectItem:=nil;
end;

//************************************************************************
//* TDynamicComboBoxHandler.AssignToComboBox
//************************************************************************
procedure TDynamicComboBoxHandler.AssignToComboBox(AComboBox: TComboBox);
begin
   FComboBox:=AComboBox;
   FComboBox.AutoComplete:=False;
   FComboBox.OnChange:=ComboChangeOnBackground;
   //FComboBox.OnClick:=ComboClick;
   FComboBox.OnDropDown:=ComboDropDown;
   FComboBox.OnKeyPress:=ComboKeyPress;
   FComboBox.OnKeyDown:=ComboKeyDown;
   FComboBox.OnCloseUp:=ComboCloseUp;

   FOldOnEnter:=FComboBox.OnEnter;
   FOldOnExit:=FComboBox.OnExit;

   FComboBox.OnEnter:=ComboEnter;
   FComboBox.OnExit:=ComboExit;
end;

(*
//************************************************************************
//* TDynamicComboBoxHandler.ComboClick
//************************************************************************
procedure TDynamicComboBoxHandler.ComboClick(Sender: TObject);
begin
   if not FLastKeyIsArrowKey then begin
      ComboChange(Sender);
   end;
   FProcessingKeyPress:=False;
   FLastKeyIsArrowKey:=False;
end;
*)

//************************************************************************
//* TDynamicComboBoxHandler.ComboChange
//************************************************************************
procedure TDynamicComboBoxHandler.ComboChange(Sender: TObject);
begin
   // Update items
   if FProcessingKeyPress then begin
      //if not FLastKeyIsArrowKey then begin
         FProcessingKeyPress:=False;
         //SelStart:=FComboBox.SelStart;
         //Text:=FComboBox.Text;
         if FComboBox.DroppedDown then begin
            Self.PopulateComboAccordingToText;
         end else begin
            FComboBox.Items.Clear;     // Make sure that the combobox will drop down with no items being shown
            FComboBox.Text:=FComboSearchText;   // When we call Items.Clear, Text and SelStart are automatically reset, so we have to fill it again.
            FComboBox.SelStart:=FComboSearchSelStart;
            FForcedDroppedDown:=True;  // Signalize OnDropDrown event handler, which will be called in the following instruction, not to populate the combobox
            try
               FComboBox.DroppedDown:=True;
            finally
               FForcedDroppedDown:=False;
            end;
            SendMessage(FComboBox.Handle,WM_SETCURSOR,0,0);
            Self.PopulateComboAccordingToText;
         end;
         //FComboBox.Text:=Text;
         //FComboBox.SelStart:=SelStart;

         FComboBox.Text:=FComboSearchText;
         FComboBox.SelStart:=FComboSearchSelStart;

         //FPopulatingCombo:=False;
      //end else begin
      //   FLastKeyIsArrowKey:=False;
      //end;
   end else begin
      try
         //Screen.Cursor:=crHourglass;
         // Update variable
         {if (FComboBox.ItemIndex<>-1) and (FComboBox.Items.Count>0) then begin
            UpdateVar_Parceiro:=POID(FArrayLookupIdParceiro[FComboBox.ItemIndex]);
         end else begin
            UpdateVar_Parceiro:=NullOID;
         end;}
         if GetCurrentThreadID=MainThreadID then begin
            // If this is the main thread, do selection event directly
            DoSelectItem;
         end else begin
            // If this is not the main thread, mark that a selection has
            // been done to sinalize it to ComboChangeOnBackgroundTerminate.
            TComboSearchThread(TThread.CurrentThread).SelectionDone:=True;
         end;
         FLastKeyIsArrowKey:=False;
      finally
         //Screen.Cursor:=crDefault;
      end;
   end;
end;

//************************************************************************
//* TDynamicComboBoxHandler.ComboChangeOnBackground
//************************************************************************
procedure TDynamicComboBoxHandler.ComboChangeOnBackground(Sender: TObject);
var
   ComboSearchThread: TComboSearchThread;
   RunThread: Boolean;
begin
   if not FLastKeyIsArrowKey then begin
      if FProcessingKeyPress then begin
         FComboSearchText:=FComboBox.Text;
         FComboSearchSelStart:=FComboBox.SelStart;
         RunThread:=False;
         if FCurrentComboSearchThread=nil then begin
            FCurrentComboSearchThread:=TComboSearchThread.Create(True);  // True = create suspended
            ComboSearchThread:=FCurrentComboSearchThread;
            //Self.ShowSpinner;
            RunThread:=True;
         end else begin
            // Se já há um próximo thread esperando, o texto de busca será sobreposto
            // por este, mais atualizado.
            if FNextComboSearchThread=nil then begin
               FNextComboSearchThread:=TComboSearchThread.Create(True);  // True = create suspended
            end;
            ComboSearchThread:=FNextComboSearchThread;
         end;
         // Setup thread
         ComboSearchThread.OnTerminate:=ComboChangeOnBackgroundTerminate;
         ComboSearchThread.FreeOnTerminate:=True;
         ComboSearchThread.ComboHandler:=Self;
         if RunThread then begin
            ComboSearchThread.Resume;
         end;
      end else begin
         DoSelectItem;
      end;
   end;
end;

//************************************************************************
//* TDynamicComboBoxHandler.ComboChangeOnBackgroundTerminate
//************************************************************************
procedure TDynamicComboBoxHandler.ComboChangeOnBackgroundTerminate(Sender: TObject);
begin
   if TComboSearchThread(Sender).SelectionDone then begin
      // Now we are running at the main thread and it is not necessary to
      // use TThread.Synchronize, considering that DoSelectItem usually
      // updates VCL controls.
      DoSelectItem;
   end;
   FCurrentComboSearchThread:=FNextComboSearchThread;
   FNextComboSearchThread:=nil;
   if FCurrentComboSearchThread<>nil then begin
      // Já há outra busca aguardando para ser feita. Dispara essa busca.
      FCurrentComboSearchThread.Resume;
   end else begin
      //Self.HideSpinner;
   end;
end;

//************************************************************************
//* TDynamicComboBoxHandler.ComboDropDown
//************************************************************************
procedure TDynamicComboBoxHandler.ComboDropDown(Sender: TObject);
begin
   if not FForcedDroppedDown then begin
      Self.PopulateComboAccordingToText;
   end;
   //FPopulatingCombo:=False;
end;

//************************************************************************
//* TDynamicComboBoxHandler.ComboKeyPress
//************************************************************************
procedure TDynamicComboBoxHandler.ComboKeyPress(Sender: TObject; var Key: Char);
begin
   {if FPopulatingCombo then begin
      Key:=#0;
      Exit;
   end;}
   if (Key<>#13) and (Key<>#27) then begin
      FProcessingKeyPress:=True;
   end else begin
      Key:=#0;  // Avoids a beep
      if FCurrentComboSearchThread=nil then begin
         FProcessingKeyPress:=False;
         if (FComboBox.ItemIndex=-1) and (FComboBox.Items.Count>0) then FComboBox.ItemIndex:=0;
         ComboChange(FComboBox);
         FComboBox.DroppedDown:=False;
      end;
   end;
end;

//************************************************************************
//* TDynamicComboBoxHandler.ComboKeyDown
//************************************************************************
procedure TDynamicComboBoxHandler.ComboKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   {if (Key<>VK_RETURN) and (Key<>VK_ESCAPE) then begin
      FProcessingKeyPress:=True;
      if ((Key=VK_UP) or (Key=VK_DOWN)) and (FComboBox.DroppedDown) then begin
         FLastKeyIsArrowKey:=True;
      end else begin
         FLastKeyIsArrowKey:=False;
      end;
   end else begin
      FLastKeyIsArrowKey:=False;
      if FCurrentComboSearchThread=nil then begin
         FProcessingKeyPress:=False;
         if (FComboBox.ItemIndex=-1) and (FComboBox.Items.Count>0) then FComboBox.ItemIndex:=0;
         ComboChange(FComboBox);
      end;
   end;}

   // VK_UP = up arrow
   // VK_DOWN = down arrow
   // VK_PRIOR = page up
   // VK_NEXT = page down
   if ((Key=VK_UP) or (Key=VK_DOWN) or (Key=VK_PRIOR) or (Key=VK_NEXT)) and (FComboBox.DroppedDown) then begin
      FLastKeyIsArrowKey:=True;
   end else begin
      FLastKeyIsArrowKey:=False;
   end;
end;

//************************************************************************
//* TDynamicComboBoxHandler.ComboEnter
//************************************************************************
procedure TDynamicComboBoxHandler.ComboEnter(Sender: TObject);
begin
   DoOldEnter;
   FComboSearchText:=FComboBox.Text;
end;

//************************************************************************
//* TDynamicComboBoxHandler.ComboExit
//************************************************************************
procedure TDynamicComboBoxHandler.ComboExit(Sender: TObject);
begin
   if FComboSearchText<>FComboBox.Text then begin
      DoSelectItem;
   end;
   DoOldExit;
end;

//************************************************************************
//* TDynamicComboBoxHandler.ComboCloseUp
//************************************************************************
procedure TDynamicComboBoxHandler.ComboCloseUp(Sender: TObject);
begin
   if FComboSearchText<>FComboBox.Text then begin
      DoSelectItem;
   end;
end;

//************************************************************************
//* TDynamicComboBoxHandler.PopulateComboAccordingToText
//************************************************************************
procedure TDynamicComboBoxHandler.PopulateComboAccordingToText;
begin
   if Trim(FComboBox.Text)<>'' then begin
      Self.DoLoadItems(FComboBox.Text);
   end else begin
      //FComboBox.Items.Clear;
      Self.DoLoadItems(FComboBox.Text);  // Para chamar o SetLength(FArrayLookupIdXXX,0);
      //SetLength(FArrayLookupIdParceiro,0);
   end;
end;

//************************************************************************
//* TDynamicComboBoxHandler.DoLoadItems
//************************************************************************
procedure TDynamicComboBoxHandler.DoLoadItems(AText: string);
begin
   if Assigned(FOnLoadItems) and (@FOnLoadItems<>nil) then begin
      FOnLoadItems(AText);
   end;
end;

//************************************************************************
//* TDynamicComboBoxHandler.DoSelectItem
//************************************************************************
procedure TDynamicComboBoxHandler.DoSelectItem;
begin
   FComboSearchText:=FComboBox.Text;
   if Assigned(FOnSelectItem) and (@FOnSelectItem<>nil) then begin
      // Thread safe, because FOnSelectItem usually deals with the User Interface
      // Commented because we are not calling FOnSelectItem(FComboBox) in a thread context anymore.
      //TThreadHack(TThread.CurrentThread).Synchronize(procedure begin FOnSelectItem(FComboBox) end);
      FOnSelectItem(FComboBox);
   end;
end;

//************************************************************************
//* TDynamicComboBoxHandler.DoOldEnter
//************************************************************************
procedure TDynamicComboBoxHandler.DoOldEnter;
begin
   if Assigned(FOldOnEnter) and (@FOldOnEnter<>nil) then begin
      FOldOnEnter(FComboBox);
   end;
end;

//************************************************************************
//* TDynamicComboBoxHandler.DoOldExit
//************************************************************************
procedure TDynamicComboBoxHandler.DoOldExit;
begin
   if Assigned(FOldOnExit) and (@FOldOnExit<>nil) then begin
      FOldOnExit(FComboBox);
   end;
end;

//************************************************************************
//* TComboSearchThread.Execute
//************************************************************************
procedure TComboSearchThread.Execute;
begin
   FSelectionDone:=False;  // Default
   FComboHandler.ComboChange(FComboHandler.ComboBox);
end;

//************************************************************************
//* ClearComboItemsWithoutLosingText
//************************************************************************
procedure ClearComboItemsWithoutLosingText(AComboBox: TComboBox);
begin
   SendMessage(AComboBox.Handle, WM_SETREDRAW, WPARAM(False), 0);
   try
      // Create all your controls here
      while AComboBox.Items.Count>0 do AComboBox.Items.Delete(0);
   finally
      // Make sure updates are re-enabled
      SendMessage(AComboBox.Handle, WM_SETREDRAW, WPARAM(True), 0);
      // Invalidate;  // Might be required to reflect the changes
   end;
end;

end.
