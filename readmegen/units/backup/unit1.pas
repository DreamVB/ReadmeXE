unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons,
  ComCtrls, ExtCtrls, Windows;

type

  { Tfrmmain }

  Tfrmmain = class(TForm)
    cboStyle: TComboBox;
    cmdCode1: TSpeedButton;
    cmdCode2: TSpeedButton;
    cmdInsert1: TSpeedButton;
    cmdInsertTemplate: TSpeedButton;
    cmdList: TSpeedButton;
    cmdInsert3: TSpeedButton;
    cmdInsert4: TSpeedButton;
    cmdList1: TSpeedButton;
    cmdImg: TSpeedButton;
    cmdNew1: TSpeedButton;
    cmdSave: TSpeedButton;
    cboHeaders: TComboBox;
    gSelections: TGroupBox;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    gChars: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    gSelections1: TGroupBox;
    Label1: TLabel;
    lblStyle: TLabel;
    lblDateTime: TLabeledEdit;
    lblInsertBefore2: TLabeledEdit;
    lblInsertAfter1: TLabeledEdit;
    lstTopics: TListBox;
    lstTopics1: TListBox;
    cmdInsert2: TSpeedButton;
    cmdNew: TSpeedButton;
    lstChars: TListBox;
    cmdblockquote: TSpeedButton;
    lstTemplates: TListBox;
    StatusBar1: TStatusBar;
    txtEd: TMemo;
    procedure cboHeadersChange(Sender: TObject);
    procedure cboStyleChange(Sender: TObject);
    procedure cmdblockquoteClick(Sender: TObject);
    procedure cmdCode1Click(Sender: TObject);
    procedure cmdCode2Click(Sender: TObject);
    procedure cmdImgClick(Sender: TObject);
    procedure cmdInsert1Click(Sender: TObject);
    procedure cmdInsert2Click(Sender: TObject);
    procedure cmdInsert3Click(Sender: TObject);
    procedure cmdInsert4Click(Sender: TObject);
    procedure cmdInsertTemplateClick(Sender: TObject);
    procedure cmdList1Click(Sender: TObject);
    procedure cmdListClick(Sender: TObject);
    procedure cmdNew1Click(Sender: TObject);
    procedure cmdSaveClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure txtEdKeyPress(Sender: TObject; var Key: char);
  private
    procedure LoadChars();
  const
    dlgFilter = 'Text Files(*.txt)|*.txt|Markdown Files(*.md)|*.md|All Files(*.*)|*.*';
  public

  end;

var
  frmmain: Tfrmmain;

implementation

{$R *.lfm}

{ Tfrmmain }

procedure Split(Delimiter: char; Str: string; ListOfStrings: TStrings);
begin
  ListOfStrings.Clear;
  ListOfStrings.Delimiter := Delimiter;
  ListOfStrings.StrictDelimiter := True; // Requires D2006 or newer.
  ListOfStrings.DelimitedText := Str;
end;

procedure tfrmmain.LoadChars();
var
  I: integer;
begin
  I := 32;
  while I <= 2048 do
  begin
    if I = 32 then
    begin
      lstchars.Items.Add('CHAR ' + IntToStr(I) + '    SPACE');
    end
    else
    begin
      lstchars.Items.Add('CHAR ' + IntToStr(I) + '    ' + WChar(I));
    end;
    Inc(I);
  end;
end;

procedure Tfrmmain.cmdInsert1Click(Sender: TObject);
begin
  if lstTopics.ItemIndex <> -1 then
  begin
    txted.SelText := lstTopics.Items[lstTopics.ItemIndex];
  end;
  txted.SetFocus;
end;

procedure Tfrmmain.cboHeadersChange(Sender: TObject);
var
  index: integer;
  I: integer;
  S: string;
begin
  index := cboHeaders.ItemIndex + 1;

  for I := 1 to index do
  begin
    S := S + '#';
  end;
  txted.SelText := S + ' ' + txted.SelText;
  txted.SetFocus;
  S := '';
end;

procedure Tfrmmain.cboStyleChange(Sender: TObject);
begin
  if cboStyle.ItemIndex = 0 then
  begin
    txted.SelText := '**' + txtEd.SelText + '**';
  end;
  if cboStyle.ItemIndex = 1 then
  begin
    txted.SelText := '*' + txtEd.SelText + '*';
  end;
  if cboStyle.ItemIndex = 2 then
  begin
    txted.SelText := '***' + txtEd.SelText + '***';
  end;
  if cboStyle.ItemIndex = 3 then
  begin
    txtEd.SelText := '~~' + txtEd.SelText + '~~';
  end;
  txted.SetFocus;
end;

procedure Tfrmmain.cmdblockquoteClick(Sender: TObject);
var
  S: string;
  lst: TStringList;
  I: integer;
  S0: string;
begin

  lst := TStringList.Create;
  S := txtEd.SelText;
  Split(#13, S, lst);
  for I := 0 to lst.Count - 1 do
  begin
    S0 := S0 + '> ' + Trim(lst[I]) + sLineBreak;
  end;
  txted.SelText := Trim(S0);

  S0 := '';
  lst.Clear;
end;

procedure Tfrmmain.cmdCode1Click(Sender: TObject);
begin
  if Pos('`', txtEd.Text) > 0 then
  begin
    txted.SelText := '``' + txtEd.SelText + '``';
  end
  else
  begin
    txted.SelText := '`' + txtEd.SelText + '`';
  end;
  txted.SetFocus;
end;

procedure Tfrmmain.cmdCode2Click(Sender: TObject);
begin
  txted.SelText := '---' + sLineBreak;
  txted.SetFocus;
end;

procedure Tfrmmain.cmdImgClick(Sender: TObject);
var
  S0: string;
begin
  S0 := Trim(InputBox('Insert Image', 'Type the descriptionof the image', ''));
  if Length(s0) > 0 then
  begin
    txted.SelText := '![' + S0 + '](' + txtEd.SelText + ')';
  end;
  txted.SetFocus;
end;

procedure Tfrmmain.cmdInsert2Click(Sender: TObject);
begin
  if lstTopics1.ItemIndex <> -1 then
  begin
    txted.SelText := lstTopics1.Items[lstTopics1.ItemIndex];
    txted.SetFocus;
  end;
end;

procedure Tfrmmain.cmdInsert3Click(Sender: TObject);
begin
  txted.SelText := lblInsertBefore2.Text + WChar(32 + lstChars.ItemIndex) +
    lblInsertAfter1.Text;
  txted.SetFocus;
end;

procedure Tfrmmain.cmdInsert4Click(Sender: TObject);
var
  myDate: TDateTime;
begin

  myDate := Now;
  txted.SelText := FormatDateTime(lblDateTime.Text, myDate);
  txted.SetFocus;
end;

procedure Tfrmmain.cmdInsertTemplateClick(Sender: TObject);
var
  sLine: string;
  sPath: string;
  sList: TStringList;
begin

  if lstTemplates.ItemIndex <> -1 then

    sLine := lstTemplates.Items[lstTemplates.ItemIndex];

  sPath := ExpandFileName(ExtractFileDir(Application.ExeName)) +
    '\tpl\' + sLine + '.txt';

  sList := TStringList.Create;
  if FileExists(sPath) then
  begin
    sList.LoadFromFile(sPath);
    txtEd.SelText := sList.GetText;
    sList.Clear;
  end;

  txted.SetFocus;

end;

procedure Tfrmmain.cmdList1Click(Sender: TObject);
var
  S: string;
  lst: TStringList;
  I: integer;
  S0: string;
begin
  S0 := '';
  lst := TStringList.Create;
  S := txtEd.SelText;

  Split(#13, S, lst);
  for I := 0 to lst.Count - 1 do
  begin
    S0 := S0 + '- ' + Trim(lst[I]) + sLineBreak;
  end;
  txted.SelText := Trim(S0);
  S0 := '';
  lst.Clear;
end;

procedure Tfrmmain.cmdListClick(Sender: TObject);
var
  S: string;
  lst: TStringList;
  I: integer;
  S0: string;
begin
  S0 := '';
  lst := TStringList.Create;
  S := txtEd.SelText;

  Split(#10, S, lst);
  for I := 0 to lst.Count - 1 do
  begin
    S0 := S0 + IntToStr(I + 1) + '. ' + Trim(lst[I]) + sLineBreak;
  end;
  txted.SelText := Trim(S0);
  S0 := '';
  lst.Clear;
end;

procedure Tfrmmain.cmdNew1Click(Sender: TObject);
var
  od: TOpenDialog;
begin
  od := TOpenDialog.Create(self);
  od.Title := 'Open';
  od.Filter := dlgFilter;

  if od.Execute then
  begin
    txted.Lines.LoadFromFile(od.FileName);
  end;
  od.Free;
  txted.SetFocus;
end;

procedure Tfrmmain.cmdSaveClick(Sender: TObject);
var
  sd: TSaveDialog;
begin
  sd := TSaveDialog.Create(self);
  sd.Title := 'Save';
  sd.Filter := dlgFilter;
  sd.DefaultExt := 'txt';

  if sd.Execute then
  begin
    txted.Lines.SaveToFile(sd.FileName);
  end;
  txted.SetFocus;
  sd.Free;
end;

procedure Tfrmmain.cmdNewClick(Sender: TObject);
var
  ButSelected: integer;
begin

  if Length(txted.Text) > 0 then
  begin

    ButSelected := MessageDlg('New', 'Are you sure you want to clear the text',
      mtInformation, [mbYes, mbNo], 0);

    if ButSelected = mrYes then
    begin
      txted.Clear;
    end;
  end;
  txted.SetFocus;
end;

procedure Tfrmmain.FormCreate(Sender: TObject);
begin
  LoadChars();
end;

procedure Tfrmmain.FormShow(Sender: TObject);
begin
  txted.SetFocus;
end;

procedure Tfrmmain.txtEdKeyPress(Sender: TObject; var Key: char);
var
  line, col, indent: integer;
  S: string;
begin

  if key = '[' then
  begin
    txted.SelText := '[]';
    txted.SelStart := txted.SelStart - 1;
    key := #0;
  end;
  if key = '(' then
  begin
    txted.SelText := '()';
    txted.SelStart := txted.SelStart - 1;
    key := #0;
  end;

  if key = '{' then
  begin
    txted.SelText := '{}';
    txted.SelStart := txted.SelStart - 1;
    key := #0;
  end;

  if key = #13 then
  begin
    key := #0;
    with Sender as TMemo do
    begin
      // figure out line and column position of caret
      line := CaretPos.Y;

      Col := SelStart - Perform(EM_LINEINDEX, line, 0);

      // get part of current line in front of caret
      S := Copy(Lines[line], 1, col);

      // count blanks and tabs in this string
      indent := 0;
      while (indent < length(S)) and (S[indent + 1] in [' ', #9]) do
        Inc(indent);

      // insert a linebreak followed by the substring of blanks and tabs
      SelText := #13#10 + Copy(S, 1, indent);
    end;
  end;
end;

end.
