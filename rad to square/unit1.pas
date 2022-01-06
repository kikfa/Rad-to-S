unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Memo1: TMemo;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    procedure Button1Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RadioButton1Change(Sender: TObject);
    procedure RadioButton2Change(Sender: TObject);
    procedure RadioButton3Change(Sender: TObject);
  private

  public

  end;


     TMyThread = class(TThread)
  private

  protected
    procedure Execute; override;
  end;

var
  Form1: TForm1;
  R1, R2 : Real;
  Rad_koef : Real = 1;
  SqThread : TMyThread;
  R1Check , R2Check : Boolean;
implementation

{$R *.lfm}

{ TForm1 }

function SqCalc (R: Real): Real;
begin
    SqCalc := Pi*R*R;
end;

procedure TMyThread.Execute;
var
   S : String;
   R : Real;
 begin
   if (R1Check and R2Check) then
    begin
      R := R1;
      Form1.Memo1.Clear();
       while R <= R2 do
        begin
         Form1.Memo1.Lines.Add (FloatToStr(SqCalc(R*Rad_koef)));
         R := R+1;
        end;
    end;
 end;

procedure TForm1.Edit1Change(Sender: TObject);
begin
  try  R1 := StrToFloat(Form1.Edit1.Text);
    R1Check := True;
   except
     Form1.Edit1.Color := clRed;
     R1Check := False;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  SqThread := TMyThread.Create(False);
end;

procedure TForm1.Edit2Change(Sender: TObject);
begin
  try R2 := StrToFloat(Form1.Edit2.Text);
   R2Check := True;
  except
    Form1.Edit2.Color := clRed;
    R2Check := False;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
   DecimalSeparator := '.' ;
   R1Check := False ;
   R2Check := False ;
end;

procedure TForm1.RadioButton1Change(Sender: TObject);
begin
  if (Form1.RadioButton1.Checked) then
  begin
   Form1.RadioButton2.Checked := False;
   Form1.RadioButton3.Checked := False;
   Rad_koef :=  0.001;
  end;
end;

procedure TForm1.RadioButton2Change(Sender: TObject);
begin
  if (Form1.RadioButton2.Checked) then
  begin
   Form1.RadioButton1.Checked := False;
   Form1.RadioButton3.Checked := False;
   Rad_koef := 0.01;
  end;
end;

procedure TForm1.RadioButton3Change(Sender: TObject);
begin
  if (Form1.RadioButton3.Checked) then
 begin
  Form1.RadioButton1.Checked := False;
  Form1.RadioButton2.Checked := False;
  Rad_koef := 1;
 end;
end;

end.

