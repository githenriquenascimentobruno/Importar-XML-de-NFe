unit uCodigoBarras;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Data.FMTBcd, Datasnap.DBClient,
  Datasnap.Provider, Data.SqlExpr, Vcl.Grids, Vcl.DBGrids, Data.DBXFirebird;

type
  TfrmGenero = class(TForm)
    DBGrid1: TDBGrid;
    conexaoBd: TSQLConnection;
    sdsProdutos: TSQLDataSet;
    dspProdutos: TDataSetProvider;
    cdsProdutos: TClientDataSet;
    dsProdutos: TDataSource;
    procedure FormShow(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmGenero: TfrmGenero;

implementation

{$R *.dfm}

uses uPrincipal;

procedure TfrmGenero.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
var

  nLinha: integer;
  CodigoProduto2 : string;
begin
  // obtém o número do registro (linha)
  nLinha := DBGrid1.DataSource.DataSet.RecNo;

  // verifica se o número da linha é par ou ímpar, aplicando as cores
  if Odd(nLinha) then
    DBGrid1.Canvas.Brush.Color := clMenu
  else
    DBGrid1.Canvas.Brush.Color := clMoneyGreen;

  // pinta a linha
  DBGrid1.DefaultDrawColumnCell(Rect, DataCol, Column, State);






     if not (gdSelected in State) then
        begin
          DBGrid1.Canvas.Font.Color:= clBlack;
          DBGrid1.Canvas.Font.Style := [fsBold];
        end
   else
        begin
          DBGrid1.Canvas.Font.Color:= clRed; //cor se for false aqui
          DBGrid1.Canvas.Font.Style := [fsBold];

        end;
//e este campo default aqui em baixo
  DBGrid1.DefaultDrawDataCell(Rect, DBGrid1.columns[datacol].field, State);
end;

procedure TfrmGenero.FormShow(Sender: TObject);
begin
  sdsProdutos.Close;
    with cdsProdutos do
       begin
          Close;
          CommandText := 'SELECT * FROM PRODUTOS WHERE P_BARRAS1 LIKE' + QuotedStr('%'+frmPrincipal.edtBarras1.Text+'%');
          Open;
      end;
  sdsProdutos.Open;

  cdsProdutos.First;
  while not cdsProdutos.Eof do
  begin
  cdsProdutos.Edit;
  if cdsProdutos.FieldByName('P_MASCULINO').AsString = 'T' then
    begin

      cdsProdutos.FieldByName('P_MASCULINO').AsString := 'MASCULINO'
    end
    else
    begin
      cdsProdutos.FieldByName('P_MASCULINO').AsString := ''
    end;


  //cdsProdutos.Edit;
  if cdsProdutos.FieldByName('P_FEMININO').AsString = 'T' then
    begin

      cdsProdutos.FieldByName('P_FEMININO').AsString := 'FEMININO'
    end
    else
    begin
      cdsProdutos.FieldByName('P_FEMININO').AsString := ''
    end;


  //cdsProdutos.Edit;
  if cdsProdutos.FieldByName('P_UNISSEX').AsString = 'T' then
    begin

      cdsProdutos.FieldByName('P_UNISSEX').AsString := 'UNISSEX'
    end
    else
    begin
      cdsProdutos.FieldByName('P_UNISSEX').AsString := ''
    end;

    cdsProdutos.Next;
  end;
end;

end.
