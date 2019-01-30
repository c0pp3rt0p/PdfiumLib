unit MainFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, PdfiumCore;

const
  cPdfControlDefaultDrawOptions = [];

type
  TForm1 = class(TForm)
    Button1: TButton;
    Image1: TImage;
    OpenDialog1: TOpenDialog;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    FDocument: TPdfDocument;
    procedure SetPage(PageIndex: Integer);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
if OpenDialog1.Execute then
  begin
    FDocument.LoadFromFile(OpenDialog1.FileName);
    OutputDebugString(PChar('Loaded file'));
    OutputDebugString(PChar('Pages = ' + IntToStr(FDocument.PageCount)));
    if FDocument.PageCount > 0 then
      SetPage(0);

  end
  else
  begin
    Application.ShowMainForm := False;
    Application.Terminate;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  //Create our masterpiece
  FDocument := TPdfDocument.Create;
end;

procedure TForm1.SetPage(PageIndex: Integer);
var
  Page: TPdfPage;
  Bitmap: TBitmap;
  PdfBitMap: TPdfBitmap;
begin
  //Create our masterpiece
  Page := FDocument.Pages[PageIndex];
  OutputDebugString(PChar('We''ve got a page = '));           ;
  Page.Draw(Image1.Canvas.Handle, 0, 0, round(Page.Width), 792, prNormal, cPdfControlDefaultDrawOptions);



end;

end.
