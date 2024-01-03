unit uMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Menus;

type

  { TfMain }

  TfMain = class(TForm)
    ImageList1: TImageList;
    miStayAwake: TMenuItem;
    miQuit: TMenuItem;
    pmMain: TPopupMenu;
    Separator1: TMenuItem;
    Timer1: TTimer;
    TrayIcon1: TTrayIcon;
    procedure FormActivate(Sender: TObject);
    procedure miStayAwakeClick(Sender: TObject);
    procedure miQuitClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private

  public

  end;

var
  fMain: TfMain;

implementation

{$R *.lfm}

const
  ES_SYSTEM_REQUIRED = DWORD($00000001);
  {$EXTERNALSYM ES_SYSTEM_REQUIRED}
  ES_DISPLAY_REQUIRED = DWORD($00000002);
  {$EXTERNALSYM ES_DISPLAY_REQUIRED}

type
  EXECUTION_STATE = DWORD;

function SetThreadExecutionState(esFlags: EXECUTION_STATE): EXECUTION_STATE;
  stdcall; external 'kernel32.dll';

{ TfMain }

procedure TfMain.miStayAwakeClick(Sender: TObject);
begin
  miStayAwake.Checked := not miStayAwake.Checked;
  Timer1.Enabled:= miStayAwake.Checked;
  if miStayAwake.Checked then
    ImageList1.GetIcon(0, TrayIcon1.Icon)
  else
    ImageList1.GetIcon(1, TrayIcon1.Icon);
end;

procedure TfMain.FormActivate(Sender: TObject);
begin
  fMain.Visible := False;
end;

procedure TfMain.miQuitClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfMain.Timer1Timer(Sender: TObject);
begin
  // Prevent Screensaver
  SetThreadExecutionState(ES_DISPLAY_REQUIRED);
  // Prevent Standby or Hibernate
  SetThreadExecutionState(ES_SYSTEM_REQUIRED);
end;

end.
