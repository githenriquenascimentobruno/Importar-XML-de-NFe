program ImportaXmlReverse;

uses
  Vcl.Forms,
  uPrincipal in 'uPrincipal.pas' {frmPrincipal},
  uCodigoBarras in 'uCodigoBarras.pas' {frmGenero};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TfrmGenero, frmGenero);
  Application.Run;
end.
