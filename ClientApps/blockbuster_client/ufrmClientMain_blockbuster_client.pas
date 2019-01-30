unit ufrmClientMain_blockbuster_client;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, Menus, ImgList, XPMan, XPMenu, jpeg, ExtCtrls, ToolWin,
  dxWinXPBar, dxCore2, dxContainer, StdCtrls, {$IFDEF NOMDI}ufrmMainForm,{$ENDIF}
  uModelClient,
  uSingletonsClient, uP2SBFAbsModelClient, uP2SBFSystemModelClient,
  uP2SBFSystemModelClientForms, uP2SBFOrbClient;

type
  THackControl = class(TControl);

  //TFormClass = class of TForm;   // Now defined in uP2SBFSystemModelClientForms. 

  TScrollBox = class(Forms.TScrollBox)
     protected
        procedure AutoScrollInView(AControl: TControl); override;
  end;

  TfrmClientMain_blockbuster_client = class(TP2SBFClientMainForm)
    imglstImagesMenus: TImageList;
    imglstImagesBarGroups: TImageList;
    mnuMainMenu: TMainMenu;
    tlbToolBar: TToolBar;
    cmdSeparatorExit: TToolButton;
    cmdExit: TToolButton;
    stsStatusBar: TStatusBar;
    XPManifest1: TXPManifest;
    XPMenu1: TXPMenu;
    imgFundo: TImage;
    scrBarraOpcoes: TScrollBox;
    pgbProgressBar: TProgressBar;
    mnuFile: TMenuItem;
    mnuConnectionStatistics: TMenuItem;
    mnuExit: TMenuItem;

//$$** SECTION: MENUS_DECLARATIONS
//$$** ENDSECTION
    
//$$** SECTION: TOOLBUTTONS_DECLARATIONS
    cmdToolButton1_1: TToolButton;
    cmdToolButton1_2: TToolButton;
    cmdToolButton2_1: TToolButton;
    cmdToolButton3_1: TToolButton;
    cmdToolButton3_2: TToolButton;
    cmdToolButton4_1: TToolButton;
    cmdToolButton5_1: TToolButton;
//$$** ENDSECTION
    
//$$** SECTION: CONTAINERS_DECLARATIONS
    cntContainer1: TdxContainer;
    cntContainer2: TdxContainer;
    cntContainer3: TdxContainer;
    cntContainer4: TdxContainer;
    cntContainer5: TdxContainer;
//$$** ENDSECTION
    
//$$** SECTION: BARS_DECLARATIONS
    barBar1: TdxWinXPBar;
    barBar2: TdxWinXPBar;
    barBar3: TdxWinXPBar;
    barBar4: TdxWinXPBar;
    barBar5: TdxWinXPBar;
//$$** ENDSECTION

    splSplitter: TSplitter;

    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
       WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure scrBarraOpcoesClick(Sender: TObject);
    procedure stsStatusBarDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel; const Rect: TRect);
    procedure mnuConnectionStatisticsClick(Sender: TObject);
    procedure mnuExitClick(Sender: TObject);

//$$** SECTION: MENUS_METHODS_DECLARATIONS
//$$** ENDSECTION

//$$** SECTION: TOOLBUTTONS_METHODS_DECLARATIONS
    procedure cmdToolButton1_1Click(Sender: TObject);
    procedure cmdToolButton1_2Click(Sender: TObject);
    procedure cmdToolButton2_1Click(Sender: TObject);
    procedure cmdToolButton3_1Click(Sender: TObject);
    procedure cmdToolButton3_2Click(Sender: TObject);
    procedure cmdToolButton4_1Click(Sender: TObject);
    procedure cmdToolButton5_1Click(Sender: TObject);
//$$** ENDSECTION

  private
    { Private declarations }
    FLoggedIn: Boolean;
    FStatsVisible: Boolean;
{$IFDEF NOMDI}
    procedure CloseSenderOwner(Sender: TObject);
{$ENDIF}
    procedure UpdateConnectionStatistics(Sender: TObject);
    procedure BeforeReconnect(Sender: TObject);
    procedure AfterReconnect(Sender: TObject);
  public
    { Public declarations }
    function ShowMDIChild(AFormName: string; AFormClass: TFormClass): TForm; override;

    procedure SetStatusBarProgress(AFrac: Double);
    procedure SetStatusBarProgressText(AText: string);
    procedure ClearStatusBarProgress;
  end;

var
  frmClientMain_blockbuster_client: TfrmClientMain_blockbuster_client;

implementation

{$R *.dfm}

//$$** SECTION: IMPLEMENTATION_USES
uses   ufrmLogin
       ,ufrmCRUDFilme
       ,ufrmCRUDSocio
       ,ufrmCRUDDiretor
       ,ufrmCRUDLog
       ,ufrmCRUDLocacao
       ,ufrmCRUDNotaDebito
       ,ufrmCRUDOrdemCompra
//$$** SECTION: IMPLEMENTATION_USES_USER
//$$** ENDSECTION
     ;

const
   ucModulePermissionId = 0;

//************************************************************************
//* TfrmClientMain_blockbuster_client.FormCreate
//************************************************************************
procedure TfrmClientMain_blockbuster_client.FormCreate(Sender: TObject);
var
   ProgressBarStyle: Integer;
begin
   // Project Name
   stsStatusBar.Panels[0].Text:=Application.Title;
   // Initialize
   FLoggedIn:=False;
   FStatsVisible:=False;
   // Setup progress bar
   // Place the progress bar into the status bar
   pgbProgressBar.Parent := stsStatusBar;
   // Remove progress bar border
   ProgressBarStyle := GetWindowLong(pgbProgressBar.Handle,GWL_EXSTYLE);
   ProgressBarStyle := ProgressBarStyle-WS_EX_STATICEDGE;
   SetWindowLong(pgbProgressBar.Handle,GWL_EXSTYLE,ProgressBarStyle);
   // Connection stats
   gP2SBFOrbClient.OnUpdateStatistics:=UpdateConnectionStatistics;
   UpdateConnectionStatistics(gP2SBFOrbClient);
   // Reconnection
   gP2SBFOrbClient.BeforeReconnect:=BeforeReconnect;
   gP2SBFOrbClient.AfterReconnect:=AfterReconnect;
end;

//************************************************************************
//* TfrmClientMain_blockbuster_client.FormActivate
//************************************************************************
procedure TfrmClientMain_blockbuster_client.FormActivate(Sender: TObject);
begin
   // Login
   if not FLoggedIn then begin
      WindowState:=wsMaximized;
      Application.CreateForm(TfrmLogin,frmLogin);
      if frmLogin.ShowModal=mrOk then begin
         FLoggedIn:=True;
         stsStatusBar.Panels[1].Text:=frmLogin.txtLogin.Text;
         stsStatusBar.Panels[2].Text:=frmLogin.txtServer.Text+':'+frmLogin.txtPort.Text;
         frmLogin.Free;
         _InitializeSingletons;
         if ucModulePermissionId>0 then begin
            if not _gSysAccessControl.CheckLoggedUserPermission(ucModulePermissionId,ptView) then begin
               Application.MessageBox('Sem permissão de acesso para este módulo.','Segurança',MB_ICONEXCLAMATION);
               Application.Terminate;            
            end;
         end;
      end else begin
         frmLogin.Free;
         Application.Terminate;
      end;
   end;
end;

//************************************************************************
//* TfrmClientMain_blockbuster_client.FormPaint
//************************************************************************
procedure TfrmClientMain_blockbuster_client.FormPaint(Sender: TObject);
var
   X,Y: Integer;
begin
   if (imgFundo.Picture.Height<>0) and (imgFundo.Picture.Width<>0) then begin
      Y:=tlbToolBar.Height;
      while Y<=ClientHeight do begin
         X:=scrBarraOpcoes.Width+splSplitter.Width;
         while X<=ClientWidth do begin
            Canvas.Draw(X,Y,imgFundo.Picture.Graphic);
            X:=X+imgFundo.Picture.Width;
         end;
         Y:=Y+imgFundo.Picture.Height;
      end;
   end;
end;

//************************************************************************
//* TfrmClientMain_blockbuster_client.FormMouseWheel
//************************************************************************
procedure TfrmClientMain_blockbuster_client.FormMouseWheel(Sender: TObject;
  Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint;
  var Handled: Boolean);
var                          
   Ctrl: TControl;
   CursPos: TPoint;
begin
   CursPos:=MousePos;
   CursPos.X:=CursPos.X-Self.Left;
   CursPos.Y:=CursPos.Y-Self.Top;
   Ctrl:=Self.ControlAtPos(CursPos,False,True);
   if Ctrl=scrBarraOpcoes then begin
      scrBarraOpcoes.VertScrollBar.Position:=scrBarraOpcoes.VertScrollBar.Position-(WheelDelta div 4);
   end;
end;

//************************************************************************
//* TfrmClientMain_blockbuster_client.scrBarraOpcoesClick
//************************************************************************
procedure TfrmClientMain_blockbuster_client.scrBarraOpcoesClick(Sender: TObject);
begin
   if scrBarraOpcoes.CanFocus then scrBarraOpcoes.SetFocus;
end;

//*****************************************************************
// TfrmClientMain_blockbuster_client.stsStatusBarDrawPanel
//*****************************************************************
procedure TfrmClientMain_blockbuster_client.stsStatusBarDrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
begin
   if Panel = StatusBar.Panels[3] then begin
      with pgbProgressBar do begin
         Top := Rect.Top;
         Left := Rect.Left;
         Width := Rect.Right - Rect.Left - 1;
         Height := Rect.Bottom - Rect.Top;
      end;
   end;
end;

//************************************************************************
//* TfrmClientMain_blockbuster_client.mnuConnectionStatisticsClick
//************************************************************************
procedure TfrmClientMain_blockbuster_client.mnuConnectionStatisticsClick(Sender: TObject);
begin
   FStatsVisible:=not FStatsVisible;
   mnuConnectionStatistics.Checked:=FStatsVisible;   
   UpdateConnectionStatistics(gP2SBFOrbClient);
end;

//************************************************************************
//* TfrmClientMain_blockbuster_client.mnuExitClick
//************************************************************************
procedure TfrmClientMain_blockbuster_client.mnuExitClick(Sender: TObject);
begin
   Close;
end;

//$$** SECTION: MENUS_METHODS
//$$** ENDSECTION

//$$** SECTION: TOOLBUTTONS_METHODS

//************************************************************************
//* TfrmClientMain_blockbuster_client.cmdToolButton1_1Click
//************************************************************************
procedure TfrmClientMain_blockbuster_client.cmdToolButton1_1Click(Sender: TObject);
begin
   ShowMDIChild('frmCRUDSocio',TfrmCRUDSocio);
end;

//************************************************************************
//* TfrmClientMain_blockbuster_client.cmdToolButton1_2Click
//************************************************************************
procedure TfrmClientMain_blockbuster_client.cmdToolButton1_2Click(Sender: TObject);
begin
   ShowMDIChild('frmCRUDDiretor',TfrmCRUDDiretor);
end;

//************************************************************************
//* TfrmClientMain_blockbuster_client.cmdToolButton2_1Click
//************************************************************************
procedure TfrmClientMain_blockbuster_client.cmdToolButton2_1Click(Sender: TObject);
begin
   ShowMDIChild('frmCRUDFilme',TfrmCRUDFilme);
end;

//************************************************************************
//* TfrmClientMain_blockbuster_client.cmdToolButton3_1Click
//************************************************************************
procedure TfrmClientMain_blockbuster_client.cmdToolButton3_1Click(Sender: TObject);
begin
   ShowMDIChild('frmCRUDLocacao',TfrmCRUDLocacao);
end;

//************************************************************************
//* TfrmClientMain_blockbuster_client.cmdToolButton3_2Click
//************************************************************************
procedure TfrmClientMain_blockbuster_client.cmdToolButton3_2Click(Sender: TObject);
begin
   ShowMDIChild('frmCRUDOrdemCompra',TfrmCRUDOrdemCompra);
end;

//************************************************************************
//* TfrmClientMain_blockbuster_client.cmdToolButton4_1Click
//************************************************************************
procedure TfrmClientMain_blockbuster_client.cmdToolButton4_1Click(Sender: TObject);
begin
   ShowMDIChild('frmCRUDNotaDebito',TfrmCRUDNotaDebito);
end;

//************************************************************************
//* TfrmClientMain_blockbuster_client.cmdToolButton5_1Click
//************************************************************************
procedure TfrmClientMain_blockbuster_client.cmdToolButton5_1Click(Sender: TObject);
begin
   ShowMDIChild('frmCRUDLog',TfrmCRUDLog);
end;
//$$** ENDSECTION

//************************************************************************
//* TfrmClientMain_blockbuster_client.ShowMDIChild
//************************************************************************
function TfrmClientMain_blockbuster_client.ShowMDIChild(AFormName: string; AFormClass: TFormClass): TForm;
var
   i: Integer;
   NewForm: TForm;
   CloseImage: TImage;
begin
{$IFNDEF NOMDI}
   Result:=nil;
   for i:=0 to Application.MainForm.MDIChildCount-1 do begin
      if Application.MainForm.MDIChildren[i].Name = AFormName then begin
         Result:=Application.MainForm.MDIChildren[i];
         Result.Show;
         Break;
      end;
   end;
   if Result=nil then begin
      Screen.Cursor:=crHourglass;
      NewForm:=AFormClass.Create(Self);
      NewForm.FormStyle:=fsMDIChild;
      NewForm.Show;
      Screen.Cursor:=crDefault;      
      Result:=NewForm;
   end;
{$ELSE}
   Result:=nil;
   // Hide current form
   if TfrmMainForm(Application.MainForm).CurrentForm<>nil then begin
      TfrmMainForm(Application.MainForm).CurrentForm.Hide;
      TfrmMainForm(Application.MainForm).CurrentForm:=nil;
   end;
   // Check if the requested form is already created
   for i:=0 to Screen.FormCount-1 do begin
      if Screen.Forms[i].Name = AFormName then begin
         TfrmMainForm(Application.MainForm).CurrentForm:=Screen.Forms[i];
         Screen.Forms[i].Show;
         if (Assigned(Screen.Forms[i].OnActivate)) and (@Screen.Forms[i].OnActivate<>nil) then begin
            Screen.Forms[i].OnActivate(Screen.Forms[i]);
         end;
         Result:=Screen.Forms[i];
         Break;
      end;
   end;
   // If the requested form is not created, create and initialize it.
   if Result=nil then begin
      Screen.Cursor:=crHourglass;
      NewForm:=AFormClass.Create(Self);
      //NewForm.Font.Name:=Application.MainForm.Font.Name;
      NewForm.Align:=alClient;
      NewForm.Parent:=Application.MainForm;
      NewForm.BorderStyle:=bsNone;
      TfrmMainForm(Application.MainForm).CurrentForm:=NewForm;
      TfrmMainForm(Application.MainForm).ModifyControl(NewForm,
                                                       procedure(AControl: TControl)
                                                       begin
                                                          if LowerCase(THackControl(AControl).Font.Name)='tahoma' then begin
                                                             THackControl(AControl).Font.Name:=Application.MainForm.Font.Name;
                                                          end;
                                                          if AControl is TComboBox then begin
                                                             TComboBox(AControl).SelStart:=0;
                                                             TComboBox(AControl).SelLength:=0;
                                                          end;
                                                          if (AControl.Name='pnlTitle') and (AControl is TPanel) then begin
                                                             CloseImage:=TImage.Create(NewForm);
                                                             CloseImage.Parent:=TPanel(AControl);
                                                             CloseImage.Picture.Assign(TfrmMainForm(Application.MainForm).imgClose.Picture);
                                                             CloseImage.Center:=True;
                                                             CloseImage.AutoSize:=False;
                                                             CloseImage.Width:=32;
                                                             CloseImage.Align:=alRight;
                                                             CloseImage.Cursor:=crHandPoint;
                                                             CloseImage.OnClick:=CloseSenderOwner;
                                                          end;
                                                       end
                                                       );
      TfrmMainForm(Application.MainForm).ChangeFormScale(NewForm,TfrmMainForm(Application.MainForm).CurrentScale);
      Screen.Cursor:=crDefault;
      NewForm.Show;
      if (Assigned(NewForm.OnActivate)) and (@NewForm.OnActivate<>nil) then begin
         NewForm.OnActivate(NewForm);
      end;
      Result:=NewForm;
   end;
{$ENDIF}
end;

{$IFDEF NOMDI}
//*******************************************************************
//* TfrmClientMain_blockbuster_client.CloseSenderOwner
//*******************************************************************
procedure TfrmClientMain_blockbuster_client.CloseSenderOwner(Sender: TObject);
begin
   if Sender is TControl then begin
      if TControl(Sender).Owner is TForm then begin
         TForm(TControl(Sender).Owner).Close;
         TfrmMainForm(Application.MainForm).CurrentForm:=nil;
      end;
   end;
end;
{$ENDIF}

//*******************************************************************
//* TfrmClientMain_blockbuster_client.UpdateConnectionStatistics
//*******************************************************************
procedure TfrmClientMain_blockbuster_client.UpdateConnectionStatistics(Sender: TObject);
begin
   if FStatsVisible then begin
      stsStatusBar.Panels[5].Text:='S: '+IntToStr(gP2SBFOrbClient.Statistics.BytesSent);
      stsStatusBar.Panels[6].Text:='R: '+IntToStr(gP2SBFOrbClient.Statistics.BytesReceived);
   end else begin
      stsStatusBar.Panels[5].Text:='';
      stsStatusBar.Panels[6].Text:='';
   end;
end;

//*******************************************************************
//* TfrmClientMain_blockbuster_client.BeforeReconnect
//*******************************************************************
procedure TfrmClientMain_blockbuster_client.BeforeReconnect(Sender: TObject);
begin
   SetStatusBarProgressText('Reconectando ...');
end;

//*******************************************************************
//* TfrmClientMain_blockbuster_client.AfterReconnect
//*******************************************************************
procedure TfrmClientMain_blockbuster_client.AfterReconnect(Sender: TObject);
begin
   SetStatusBarProgressText('');
end;

//*******************************************************************
//* TfrmClientMain_blockbuster_client.SetStatusBarProgress
//*******************************************************************
procedure TfrmClientMain_blockbuster_client.SetStatusBarProgress(AFrac: Double);
begin
   if not pgbProgressBar.Visible then pgbProgressBar.Visible:=True;
   pgbProgressBar.Position:=Round(AFrac*100);
end;

//*******************************************************************
//* TfrmClientMain_blockbuster_client.SetStatusBarProgressText
//*******************************************************************
procedure TfrmClientMain_blockbuster_client.SetStatusBarProgressText(AText: string);
begin
   stsStatusBar.Panels[4].Text:=AText;
   stsStatusBar.Repaint;
end;

//*******************************************************************
//* TfrmClientMain_blockbuster_client.ClearStatusBarProgress
//*******************************************************************
procedure TfrmClientMain_blockbuster_client.ClearStatusBarProgress;
begin
   stsStatusBar.Panels[4].Text:='';
   pgbProgressBar.Position:=0;
   pgbProgressBar.Visible:=False;
end;

//*******************************************************************
//* TScrollBox.AutoScrollInView
//*******************************************************************
procedure TScrollBox.AutoScrollInView(AControl: TControl);
begin
   // Disable "auto scroll in view" of the left menu scroll bar
   //inherited AutoScrollInView(AControl);
end;

end.
