unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls;

type
  TForm1 = class(TForm)
    dbgrd1: TDBGrid;
    lbl1: TLabel;
    lbl2: TLabel;
    edt1: TEdit;
    edt2: TEdit;
    btnsimpan: TButton;
    btnedit: TButton;
    btnhapus: TButton;
    btnbatal: TButton;
    edt3: TEdit;
    procedure btnsimpanClick(Sender: TObject);
    procedure btneditClick(Sender: TObject);
    procedure btnhapusClick(Sender: TObject);
    procedure btnbatalClick(Sender: TObject);
    procedure dbgrd1CellClick(Column: TColumn);
    procedure edt3Change(Sender: TObject);
    procedure posisiawal;

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  a : string;
implementation

uses
  Unit2;

{$R *.dfm}

procedure TForm1.btnsimpanClick(Sender: TObject);
begin
  if edt1.Text = '' then
  begin
    ShowMessage('Nama satuan tidak boleh kosong');
    end
  else if DataModule2.zqry1.Locate('nama', edt1.Text, []) then
  begin
    ShowMessage('Nama Satuan ' + edt1.Text + ' sudah ada dalam sistem');
  end
  else
  begin
    with DataModule2.zqry1 do
    begin
      Insert;
      SQL.Clear;
      SQL.Add('INSERT INTO satuan VALUES (NULL, "' + edt1.Text + '", "' + edt2.Text + '")');
      ExecSQL;
      SQL.Clear;
      SQL.Add('SELECT * FROM satuan');
      Open;
    end;
    ShowMessage('Data berhasil disimpan');
  end;
  posisiawal;
end;

procedure TForm1.btneditClick(Sender: TObject);
begin
//kode update
  if edt1.Text = '' then
begin
  ShowMessage('Nama Satuan tidak boleh kosong');
end
else if (edt1.Text = DataModule2.zqry1.FieldByName('nama').AsString) and (edt2.Text = DataModule2.zqry1.FieldByName('deskripsi').AsString) then
begin
  ShowMessage('Nama Satuan ' + edt1.Text + ' dan deskripsi tidak mengalami perubahan');
end
else
begin
  with DataModule2.zqry1 do
  begin
    SQL.Clear;
    SQL.Add('UPDATE satuan SET nama="' + edt1.Text + '", deskripsi="' + edt2.Text + '" WHERE id="' + a + '"');
    ExecSQL;

    SQL.Clear;
    SQL.Add('SELECT * FROM satuan');
    Open;
  end;
  ShowMessage('Data berhasil disimpan');
end;
posisiawal;
end;

procedure TForm1.btnhapusClick(Sender: TObject);
begin
//kode delete
if MessageDlg('Apakah Anda Yakin Menghapus Data Ini',mtWarning,[mbYes,mbNo],0)=mryes then
begin
with DataModule2.zqry1 do
begin
     SQL.Clear;
     SQL.Add('delete from satuan where id="'+a+'"');
     ExecSQL;

     SQL.Clear;
     SQL.Add('select * from satuan');
     Open;
end;
   ShowMessage('Data Berhasil DiDelete!');
end else
begin
  ShowMessage('Data Batal Dihapus!');
end;
posisiawal;
end;


procedure TForm1.btnbatalClick(Sender: TObject);
begin
// batal
edt1.Text := '';
edt2.Text := '';
end;

procedure TForm1.dbgrd1CellClick(Column: TColumn);
begin
edt1.Text:=DataModule2.zqry1.Fields[1].AsString;
edt2.Text:=DataModule2.zqry1.Fields[2].AsString;
a:= DataModule2.zqry1.Fields[0].AsString;
end;

procedure TForm1.edt3Change(Sender: TObject);
begin
  //kode search
begin
with DataModule2.zqry1 do
begin
  SQL.Clear;
  SQL.Add('select * from satuan where nama like"%'+edt3.Text+'%"');
  Open;
end;
end;
posisiawal;
end;

procedure TForm1.posisiawal;
begin
  edt1.Clear;
  edt2.Clear;
end;

end.
