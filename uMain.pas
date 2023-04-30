unit uMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Edit, FMX.Controls.Presentation, Data.Bind.Controls, FMX.Layouts,
  Fmx.Bind.Navigator, FMX.EditBox, FMX.SpinBox, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys,
  FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.FMXUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Comp.DataSet, System.IOUtils, System.Rtti,
  System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope //Para hacer uso de TPath
  ;

type
  TfrmMain = class(TForm)
    ToolBar1: TToolBar;
    btnOpenDB: TButton;
    Panel1: TPanel;
    edtNoControl: TEdit;
    edtNombre: TEdit;
    spnEdad: TSpinBox;
    dtmFecha: TEdit;
    BindNavigator1: TBindNavigator;
    StatusBar1: TStatusBar;
    lblStatus: TLabel;
    tblAlumno: TFDTable;
    db: TFDConnection;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkControlToField1: TLinkControlToField;
    LinkControlToField2: TLinkControlToField;
    LinkControlToField3: TLinkControlToField;
    LinkControlToField4: TLinkControlToField;
    rdbF: TRadioButton;
    rdbM: TRadioButton;
    LinkPropertyToFieldIsChecked: TLinkPropertyToField;
    LinkPropertyToFieldIsChecked2: TLinkPropertyToField;
    procedure FormCreate(Sender: TObject);
    procedure btnOpenDBClick(Sender: TObject);
    procedure rdClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;
  dbFileName: String;

implementation

{$R *.fmx}

procedure TfrmMain.btnOpenDBClick(Sender: TObject);
begin
  if not db.Connected then
  begin
    // intentar abrir la bd
   try
     db.Connected := true;
     btnOpenDB.Text:='Desconectar';
     lblStatus.Text := 'db ON';
     Panel1.Enabled := true;
     tblAlumno.Active := true;
   except on E: Exception do
    lblStatus.Text := 'db OFF : error intentando abrir';
   end;
  end
  else
  begin
    try
     db.Connected := false;
     btnOpenDB.Text:='Conectar';
     lblStatus.Text := 'db OFF';
     Panel1.Enabled := false;
     tblAlumno.Active := false;
   except on E: Exception do
    lblStatus.Text := 'db ON : error intentando cerrar';
   end;

  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
 // por si se olvida desconcetar en tiempo de diseño
 db.Connected := false;
 // configurar el componente de conexion FDConnection
 // ubicacion de la bd
 {$IF DEFINED(MSWINDOWS)}
 // windows
 dbFileName := '.\escolar.db';
 {$ELSE}
   // Android, iOS, Mac
   dbFileName := TPath.Combine(TPath.GetDocumentsPath,'escolar.db');
 {$ENDIF}
   db.Params.Database := dbFileName;
   lblStatus.Text := 'db off';
   // para evitar que el usuario intente usar los datos
   Panel1.Enabled := false;

end;
procedure TfrmMain.rdClick(Sender: TObject);
begin
  if Sender=rdbM then
  begin
    if not TRadioButton(Sender).IsChecked then
    begin
      tblAlumno.Edit;
      tblAlumno.FieldByName('sexo').AsString:='M';
    end;
  end
  else if Sender=rdbF then
  begin
    if not TRadioButton(Sender).IsChecked then
    begin
      tblAlumno.Edit;
      tblAlumno.FieldByName('sexo').AsString:='F';
    end;
  end;

end;

end.
