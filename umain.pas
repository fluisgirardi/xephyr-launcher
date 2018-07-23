unit umain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ButtonPanel;

type

  { TForm1 }

  TForm1 = class(TForm)
    ButtonPanel1: TButtonPanel;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    ComboBox4: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure CancelButtonClick(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

uses Unix;

{$R *.lfm}

{ TForm1 }

procedure TForm1.OKButtonClick(Sender: TObject);
var
  XServerCmd, exportVarCmd, wmanager: String;
begin
  if (ComboBox1.ItemIndex=-1) or (ComboBox2.ItemIndex=-1) or (ComboBox3.ItemIndex=-1) or (ComboBox4.ItemIndex=-1) then
    raise Exception.Create('Selecione valores para todos os campos!');

  Hide;
  Application.ProcessMessages;

  XServerCmd:='';
  case ComboBox1.ItemIndex of
    0: XServerCmd:=Format('Xephyr %s -screen %s',  [ComboBox4.Items[ComboBox4.ItemIndex], ComboBox2.Items[ComboBox2.ItemIndex]]);
    1: XServerCmd:=Format('Xnest %s -geometry %s', [ComboBox4.Items[ComboBox4.ItemIndex], ComboBox2.Items[ComboBox2.ItemIndex]]);
  end;

  exportVarCmd:=Format('export DISPLAY=%s',[ComboBox4.Items[ComboBox4.ItemIndex]]);

  case ComboBox3.ItemIndex of
    0: wmanager:=Format('wmaker -display %s',    [ComboBox4.Items[ComboBox4.ItemIndex]]);
    1: wmanager:=Format('DISPLAY=%s openbox',    [ComboBox4.Items[ComboBox4.ItemIndex]]);
    2: wmanager:=Format('metacity --display=%s', [ComboBox4.Items[ComboBox4.ItemIndex]]);

  end;

  fpSystem('bash -c "'+XServerCmd+' & '+exportVarCmd+' & '+wmanager+'"');
  Application.Terminate;
end;

procedure TForm1.CancelButtonClick(Sender: TObject);
begin
  Application.Terminate;
end;

end.

