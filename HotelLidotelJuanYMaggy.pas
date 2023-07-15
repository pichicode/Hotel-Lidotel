program HotelLidotelJuanYMaggy;

uses
  SysUtils, Crt;

const
  groupc = 30;
  ninosc = 10;

type
  clientinf = record
    clname: array[1..groupc] of string;
    correo: array[1..groupc] of string;
    tlf: array[1..groupc] of string;
    id: array[1..groupc] of string;
    ninos: array[1..ninosc] of string;
    edad: array[1..ninosc] of integer;
    roomnum: string;
    roomtype: string;
    ninoscant: integer;
    adultcant: integer;
    dias : integer;
  end;

  info = file of clientinf;

var
  padinfo: info;
  iadinfo: info;
  acadinfo: info;
  adclient: clientinf;
  i, x: integer;

function arcnums(const str: string): Boolean;
var
  i: Integer;
begin
  for i := 1 to Length(str) do
  begin
    if str[i] in ['0'..'9'] then
    begin
      arcnums := True;
      Exit;
    end;
  end;
  arcnums := False;
end;

procedure inicarch(var padinfo: info; var iadinfo: info; var acadinfo: info);
begin
  Assign(padinfo, 'Pareja.dat');
  Assign(iadinfo, 'Individual.dat');
  Assign(acadinfo, 'Grupo.dat');
  {$I-}
  Reset(padinfo);
  Reset(iadinfo);
  Reset(acadinfo);
  {$I+}
  if IOResult <> 0 then
  begin
    Rewrite(padinfo);
    Rewrite(iadinfo);
    Rewrite(acadinfo);
  end;
end;

function avairoomnum(roomnum: string; var padinfo: info; var iadinfo: info; var acadinfo: info): Boolean;
var
  presarch: info;
begin
  Assign(presarch, 'Pareja.dat');
  Reset(presarch);
  if IOResult = 0 then
  begin
    while not EOF(presarch) do
    begin
      Read(presarch, adclient);
      if adclient.roomnum = roomnum then
      begin
        Close(presarch);
        avairoomnum := True;
        Exit;
      end;
    end;
    Close(presarch);
  end;

  Assign(presarch, 'Individual.dat');
  Reset(presarch);
  if IOResult = 0 then
  begin
    while not EOF(presarch) do
    begin
      Read(presarch, adclient);
      if adclient.roomnum = roomnum then
      begin
        Close(presarch);
        avairoomnum := True;
        Exit;
      end;
    end;
    Close(presarch);
  end;

  Assign(presarch, 'Grupo.dat');
  Reset(presarch);
  if IOResult = 0 then
  begin
    while not EOF(presarch) do
    begin
      Read(presarch, adclient);
      if adclient.roomnum = roomnum then
      begin
        Close(presarch);
        avairoomnum := True;
        Exit;
      end;
    end;
    Close(presarch);
  end;

  avairoomnum := False;
end;

procedure datahabmostrar(roomtype: string);
begin
  case roomtype of
    'S':
      begin
        writeln('Habitación Sencilla:');
        writeln('-------------------');
        writeln('Esta habitación es ideal para una persona, si viene por trabajo, esta habitacion podria resultarle perfecta.');
        
      end;
    'T':
      begin
        writeln('Suite:');
        writeln('-------');
        writeln('Esta habitación es ideal para una pareja, pero podria resultar muy comoda para una persona');
        
      end;
    'D':
      begin
        writeln('Habitación Doble Cama:');
        writeln('-----------------');
        writeln('Esta habitación es para dos personas que desean camas separadas, ideal para compartir con compañeros de trabajo, amigos o familiares.');
        
      end;
    'F':
      begin
        writeln('Suite Familiar:');
        writeln('------------');
        writeln('Esta habitación es para familias, de amplio tamano para la comodidad de todos.');
        
      end;
  end;
end;

procedure disphabsh;
begin
  writeln('Disponibilidad:');
  writeln('------------------------');
  writeln('S. Sencilla');
  writeln('T. Suite');
  writeln('D. Doble Cama');
  writeln('F. Suite Familiar');
  writeln('------------------------');
end;

function arrobarchl(correo: string): Boolean;
begin
  arrobarchl := Pos('@', correo) > 0;
end;

procedure agregarinfo(var padinfo: info; var iadinfo: info; var acadinfo: info);
var
  adclient : clientinf;
  hosptype: char;
  roomtype: char;
  roomnum: string;
  adnum: integer;
  i, x: integer;
begin
 if IOresult = 0 then
 begin
    Close(padinfo);
    Close(iadinfo);
    Close(acadinfo);
 end;
  clrscr;
  writeln('//////Agregar Registro\\\\\\');

  
  repeat
    writeln('Ingrese el tipo de hospedaje:');
    writeln('I. Individual');
    writeln('P. Pareja');
    writeln('G. Grupo');
    write('Opción: ');
    hosptype := UpCase(ReadKey);
    writeln(hosptype);
  until (hosptype = 'I') or (hosptype = 'P') or (hosptype = 'G');

  
  if hosptype = 'G' then
  begin
    Assign(acadinfo, 'Grupo.dat');
    Reset(acadinfo);
    writeln('Datos adicionales para Grupo:');
    writeln;

    repeat
      writeln('¿Cantidad de adultos que se hospedaran? ');
      readln(adnum);
      adclient.adultcant := adnum;
    until adnum > 0;

    for i := 1 to adnum do
    begin
      writeln;
      writeln('Datos de la persona ', i);
      writeln('------------------');
      write('Cedula: ');
      readln(adclient.id[i]);
      write('Nombre completo: ');
      readln(adclient.clname[i]);
      write('Email: ');
      readln(adclient.correo[i]);
      write('Numero Telefonico: ');
      readln(adclient.tlf[i]);
    end;

    repeat
      writeln;
      write('¿Cantidad de ninos que se hospedaran? ');
      readln(x);
      adclient.ninoscant := x;
    until x >= 0;

    for i := 1 to x do
    begin
      writeln;
      writeln('Datos del nino/a ', i);
      writeln('-----------------');
      write('Nombre Completo: ');
      readln(adclient.ninos[i]);
      write('Edad: ');
      readln(adclient.edad[i]);
    end;

    Close(acadinfo);
  end
  else if hosptype = 'P' then
  begin
    Assign(padinfo, 'Pareja.dat');
    Reset(padinfo);
    writeln('Datos para Pareja:');
    writeln;
    write('Proporcione el primer nombre completo: ');
    readln(adclient.clname[1]);
    write('Proporcione el segundo nombre completo: ');
    readln(adclient.clname[2]);
    write('Proporcione el Email de ', adclient.clname[1], ': ');
    readln(adclient.correo[1]);
    write('Proporcione el Email de ', adclient.clname[2], ': ');
    readln(adclient.correo[2]);
    write('Proporcione el numero telefonico de ', adclient.clname[1], ': ');
    readln(adclient.tlf[1]);
    write('Proporcione el numero telefonico de ', adclient.clname[2], ': ');
    readln(adclient.tlf[2]);
    write('Proporcione la cédula de ', adclient.clname[1], ': ');
    readln(adclient.id[1]);
    write('Proporcione la cédula de ', adclient.clname[2], ': ');
    readln(adclient.id[2]);

    Close(padinfo);
  end
  else
  begin
    Assign(iadinfo, 'Individual.dat');
    Reset(iadinfo);

    
    adclient.roomnum := '';
    adclient.roomtype := '';
    adclient.clname[1] := '';
    adclient.id[1] := '';
    adclient.correo[1] := '';
    adclient.tlf[1] := '';

    
    repeat
      writeln('Cédula: ');
      readln(adclient.id[1]);
    until arcnums(adclient.id[1]);

    
    writeln('Nombre completo: ');
    readln(adclient.clname[1]);


    repeat
      writeln('Email: ');
      readln(adclient.correo[1]);
    until arrobarchl(adclient.correo[1]);

    
    repeat
      writeln('Numero Telefonico: ');
      readln(adclient.tlf[1]);
    until arcnums(adclient.tlf[1]);

    Close(iadinfo);
  end;

  
  repeat
    clrscr;
    disphabsh;
    write('Seleccione una opción: ');
    roomtype := UpCase(ReadKey);
    writeln(roomtype);
  until (roomtype = 'S') or (roomtype = 'T') or (roomtype = 'D') or (roomtype = 'F');
    writeln('');
    WriteLn('Cuantos dias se desea alojarse?');
    readln(adclient.dias);
  
  datahabmostrar(roomtype);

  
  repeat
    writeln;
    write('Inserte el numero de habitación: ');
    readln(roomnum);
    if avairoomnum(roomnum, padinfo, iadinfo, acadinfo) then
    begin
      writeln('El numero de habitación ya esta ocupado. Por favor, seleccione otro.');
      readln;
    end;
  until not avairoomnum(roomnum, padinfo, iadinfo, acadinfo);

  
  adclient.roomnum := roomnum;
  adclient.roomtype := roomtype;

  case hosptype of
    'I':
      begin
        Assign(iadinfo, 'Individual.dat');
        Reset(iadinfo);
        Seek(iadinfo, FileSize(iadinfo));
        Write(iadinfo, adclient);
        Close(iadinfo);
      end;
    'P':
      begin
        Assign(padinfo, 'Pareja.dat');
        Reset(padinfo);
        Seek(padinfo, FileSize(padinfo));
        Write(padinfo, adclient);
        Close(padinfo);
      end;
    'A':
      begin
        Assign(acadinfo, 'Grupo.dat');
        Reset(acadinfo);
        Seek(acadinfo, FileSize(acadinfo));
        Write(acadinfo, adclient);
        Close(acadinfo);
      end;
  end;

  writeln;
  writeln('Registro agregado correctamente.');
  readln;
end;

procedure mostrarinfo(var padinfo: info; var iadinfo: info; var acadinfo: info);
var
  presarch: info;
  adclient: clientinf;
begin
  if IOresult = 0 then
  begin
    Close(padinfo);
    Close(iadinfo);
    Close(acadinfo);
  end;
  clrscr;
  writeln('/////Mostrar Datos\\\\\');
  writeln('T. Todos');
  writeln('I. Individual');
  writeln('P. Pareja');
  writeln('A. Grupo');
  writeln('------------------------');
  write('Seleccione una opción: ');
  case UpCase(ReadKey) of
    'T':
      begin
        Assign(presarch, 'Individual.dat');
        Reset(presarch);
        writeln('/////Hospedajes Individuales\\\\\');
        while not EOF(presarch) do
        begin
          Read(presarch, adclient);
          writeln('Cédula: ', adclient.id[1]);
          writeln('Nombre y Apellido: ', adclient.clname[1]);
          writeln('correo: ', adclient.correo[1]);
          writeln('Teléfono: ', adclient.tlf[1]);
          writeln('Habitación: ', adclient.roomnum);
          writeln('Tipo de Habitación: ', adclient.roomtype);
          writeln('dias: ', adclient.dias);
          writeln;
        end;
        Close(presarch);

        Assign(presarch, 'Pareja.dat');
        Reset(presarch);
        writeln('/////Hospedajes en Pareja\\\\\');
        while not EOF(presarch) do
        begin
          Read(presarch, adclient);
          writeln('Cedula: ', adclient.id[1]);
          writeln('Nombre completo: ', adclient.clname[1]);
          writeln('Email: ', adclient.correo[1]);
          writeln('Numero Telefonico: ', adclient.tlf[1]);
          writeln('Numero de Habitacion: ', adclient.roomnum);
          writeln('Tipo de Habitacion: ', adclient.roomtype);
          writeln('dias: ', adclient.dias);
          writeln('------------------------------');
          writeln('Cedula: ', adclient.id[2]);
          writeln('Nombre Completo: ', adclient.clname[2]);
          writeln('Email: ', adclient.correo[2]);
          writeln('Telefono: ', adclient.tlf[2]);
          writeln('Numero de Habitacion: ', adclient.roomnum);
          writeln('Tipo de Habitacion: ', adclient.roomtype);
          writeln('dias: ', adclient.dias);
          writeln;
        end;
        Close(presarch);

        Assign(presarch, 'Grupo.dat');
        Reset(presarch);
        writeln('/////Hospedajes Grupo\\\\\');
        while not EOF(presarch) do
        begin
          Read(presarch, adclient);
          writeln('Cantidad de adultos: ', adclient.adultcant);
          writeln('------------------------------');
          for i := 1 to adclient.adultcant do
          begin
            writeln('Adulto ', i);
            writeln('Cedula: ', adclient.id[i]);
            writeln('Nombre Completo: ', adclient.clname[i]);
            writeln('Email: ', adclient.correo[i]);
            writeln('Numero Telefonico: ', adclient.tlf[i]);
            writeln('Numero de Habitacion: ', adclient.roomnum);
            writeln('Tipo de Habitacion: ', adclient.roomtype);
            writeln('dias: ', adclient.dias);
            writeln;
          end;
          writeln('------------------------------');
          writeln('Cantidad de niños: ', adclient.ninoscant);
          for i := 1 to adclient.ninoscant do
          begin
            writeln('Nino ', i);
            writeln('Nombre Completo: ', adclient.ninos[i]);
            writeln('Edad: ', adclient.edad[i]);
            writeln;
          end;
          writeln('------------------------------');
        end;
        Close(presarch);
      end;
    'I':
      begin
        Assign(presarch, 'Individual.dat');
        Reset(presarch);
        writeln('/////Hospedajes Individuales\\\\\');
        while not EOF(presarch) do
        begin
          Read(presarch, adclient);
          writeln('Cedula: ', adclient.id[1]);
          writeln('Nombre Completo: ', adclient.clname[1]);
          writeln('Email: ', adclient.correo[1]);
          writeln('Telefono: ', adclient.tlf[1]);
          writeln('Habitacion: ', adclient.roomnum);
          writeln('Tipo de Habitacion: ', adclient.roomtype);
          writeln('dias: ', adclient.dias);
          writeln;
        end;
        Close(presarch);
      end;
    'P':
      begin
        Assign(presarch, 'Pareja.dat');
        Reset(presarch);
        writeln('***** Hospedajes en Pareja *****');
        while not EOF(presarch) do
        begin
          Read(presarch, adclient);
          writeln('Cedula: ', adclient.id[1]);
          writeln('Nombre Completo: ', adclient.clname[1]);
          writeln('Email: ', adclient.correo[1]);
          writeln('Numero Telefonico: ', adclient.tlf[1]);
          writeln('Numero de Habitacion: ', adclient.roomnum);
          writeln('Tipo de Habitacion: ', adclient.roomtype);
          writeln('dias: ', adclient.dias);
          writeln('------------------------------');
          writeln('Cedula: ', adclient.id[2]);
          writeln('Nombre Completo: ', adclient.clname[2]);
          writeln('Email: ', adclient.correo[2]);
          writeln('Numero Telefonico: ', adclient.tlf[2]);
          writeln('Numero deHabitacion: ', adclient.roomnum);
          writeln('Tipo de Habitacion: ', adclient.roomtype);
          writeln('dias: ', adclient.dias);
          writeln;
        end;
        Close(presarch);
      end;
    'A':
      begin
        Assign(presarch, 'Grupo.dat');
        Reset(presarch);
        writeln('***** Hospedajes Grupo *****');
        while not EOF(presarch) do
        begin
          Read(presarch, adclient);
          writeln('Cantidad de adultos: ', adclient.adultcant);
          writeln('------------------------------');
          for i := 1 to adclient.adultcant do
          begin
            writeln('Adulto ', i);
            writeln('Cedula: ', adclient.id[i]);
            writeln('Nombre Completo: ', adclient.clname[i]);
            writeln('Email: ', adclient.correo[i]);
            writeln('Numero Telefonico: ', adclient.tlf[i]);
            writeln('Numero de Habitacion: ', adclient.roomnum);
            writeln('Tipo de Habitacion: ', adclient.roomtype);
            writeln('dias: ', adclient.dias);
            writeln;
          end;
          writeln('------------------------------');
          writeln('Cantidad de ninos: ', adclient.ninoscant);
          for i := 1 to adclient.ninoscant do
          begin
            writeln('Nino ', i);
            writeln('Nombre Completo: ', adclient.ninos[i]);
            writeln('Edad: ', adclient.edad[i]);
            writeln;
          end;
          writeln('------------------------------');
        end;
        Close(presarch);
      end;
  end;
end;

procedure buscarinfo(var padinfo: info; var iadinfo: info; var acadinfo: info);
var
  presarch: info;
  idBuscar: string;
begin
 if IOresult = 0 then
 begin
    Close(padinfo);
    Close(iadinfo);
    Close(acadinfo);
 end;
  clrscr;
  writeln('/////Buscar Datos\\\\\');
  write('Inserte el numero de cedula: ');
  readln(idBuscar);
  writeln;

  Assign(presarch, 'Individual.dat');
  Reset(presarch);
  writeln('/////Resultados de busqueda en Hospedajes Individuales\\\\\');
  while not EOF(presarch) do
  begin
    Read(presarch, adclient);
    if adclient.id[1] = idBuscar then
    begin
      writeln('Cedula: ', adclient.id[1]);
      writeln('Nombre Completo: ', adclient.clname[1]);
      writeln('Email: ', adclient.correo[1]);
      writeln('Numero Telefonico: ', adclient.tlf[1]);
      writeln('Numero de Habitacion: ', adclient.roomnum);
      writeln('Tipo de Habitacion: ', adclient.roomtype);
      writeln('dias: ', adclient.dias);
      writeln;
    end;
  end;
  Close(presarch);

  Assign(presarch, 'Pareja.dat');
  Reset(presarch);
  writeln('/////Resultados de la búsqueda en Hospedajes en Pareja\\\\\');
  while not EOF(presarch) do
  begin
    Read(presarch, adclient);
    if adclient.id[1] = idBuscar then
    begin
      writeln('Cedula: ', adclient.id[1]);
      writeln('Nombre Completo: ', adclient.clname[1]);
      writeln('Email: ', adclient.correo[1]);
      writeln('Numero Telefonico: ', adclient.tlf[1]);
      writeln('Numero de Habitacion: ', adclient.roomnum);
      writeln('Tipo de Habitacion: ', adclient.roomtype);
      writeln('dias: ', adclient.dias);
      writeln;
    end;
  end;
  Close(presarch);

  Assign(presarch, 'Grupo.dat');
  Reset(presarch);
  writeln('***** Resultados de la búsqueda en Hospedajes Grupo *****');
  while not EOF(presarch) do
  begin
    Read(presarch, adclient);
    if adclient.id[1] = idBuscar then
    begin
      writeln('Cedula: ', adclient.id[1]);
      writeln('Nombre Completo: ', adclient.clname[1]);
      writeln('Email: ', adclient.correo[1]);
      writeln('Telefono: ', adclient.tlf[1]);
      writeln('Numero de Habitacion: ', adclient.roomnum);
      writeln('Tipo de Habitacion: ', adclient.roomtype);
      writeln('dias: ', adclient.dias);
      writeln;
    end;
  end;
  Close(presarch);

  readln;
end;

procedure FacturarPorid(var padinfo: info; var iadinfo: info; var acadinfo: info);
var
  i, j, x: integer;
  id: string;
  encontrado: Boolean;
  presarch: info;
  cliente: clientinf;
begin
 if IOresult = 0 then
 begin
    Close(padinfo);
    Close(iadinfo);
    Close(acadinfo);
 end;
  clrscr;
  writeln('/////Facturacion por Cedula\\\\\');
  writeln('Ingrese el número de cedula: ');
  readln(id);

 
  Assign(presarch, 'Individual.dat');
  Reset(presarch);
  encontrado := False;
  while not EOF(presarch) do
  begin
    Read(presarch, cliente);
    if cliente.id[1] = id then
    begin
      writeln('Facturacion para Hospedaje Individual:');
      writeln('-----------------------------------');
      writeln('Cedula: ', cliente.id[1]);
      writeln('Nombre Completo: ', cliente.clname[1]);
      writeln('Email: ', cliente.correo[1]);
      writeln('Numero Telefonico: ', cliente.tlf[1]);
      writeln('Numero de habitacion: ', cliente.roomnum);
      writeln('Tipo de habitacion: ', cliente.roomtype[1]);
      writeln('dias: ', cliente.dias);
      encontrado := True;
      Break;
    end;
  end;
  Close(presarch);

  if not encontrado then
  begin
    
    Assign(presarch, 'Pareja.dat');
    Reset(presarch);
    encontrado := False;
    while not EOF(presarch) do
    begin
      Read(presarch, cliente);
      if (cliente.id[1] = id) or (cliente.id[2] = id) then
      begin
        writeln('Facturacion para Hospedaje en Pareja:');
        writeln('----------------------------------');
        writeln('Primer nombre completo: ', cliente.clname[1]);
        writeln('Segundo nombre completo: ', cliente.clname[2]);
        writeln('Email de ', cliente.clname[1], ': ', cliente.correo[1]);
        writeln('Email de ', cliente.clname[2], ': ', cliente.correo[2]);
        writeln('Numero Telefonico de ', cliente.clname[1], ': ', cliente.tlf[1]);
        writeln('Numero Telefonico de ', cliente.clname[2], ': ', cliente.tlf[2]);
        writeln('Numero de cedula de ', cliente.clname[1], ': ', cliente.id[1]);
        writeln('Numero de cedula de ', cliente.clname[2], ': ', cliente.id[2]);
        writeln('Numero de habitacion: ', cliente.roomnum);
        writeln('Tipo de habitacion: ', cliente.roomtype[1]);
        writeln('dias: ', cliente.dias);
        encontrado := True;
        Break;
      end;
    end;
    Close(presarch);
  end;

  if not encontrado then
  begin
    
    Assign(presarch, 'Grupo.dat');
    Reset(presarch);
    encontrado := False;
    while not EOF(presarch) do
    begin
      Read(presarch, cliente);
      for i := 1 to adclient.adultcant do
      begin
        if cliente.id[i] = id then
        begin
          writeln('Facturación para Cliente Grupo:');
          writeln('-----------------------------------');
          writeln('Cantidad de adultos: ', cliente.adultcant);
          for j := 1 to adclient.adultcant do
          begin
            writeln('Adulto ', i);
            writeln('Cedula: ', cliente.id[i]);
            writeln('Nombre completo: ', cliente.clname[i]);
            writeln('Email: ', cliente.correo[i]);
            writeln('Numero Telefonico: ', cliente.tlf[i]);
            writeln('------------------------');
          end;
          writeln('Cantidad de ninos: ', cliente.ninoscant);
          for x := 1 to cliente.ninoscant do
          begin
            writeln('Nino ', i);
            writeln('Nombre completo: ', cliente.ninos[i]);
            writeln('Edad: ', cliente.edad[i]);
            writeln('------------------------');
          end;
          writeln('Numero de habitacion: ', cliente.roomnum);
          writeln('Tipo de habitacion: ', cliente.roomtype[1]);
          writeln('dias: ', cliente.dias);
          encontrado := True;
          Break;
        end;
      end;
      if encontrado then
        Break;
    end;
    Close(presarch);
  end;

  if not encontrado then
    writeln('No se encontro ningun cliente con el número de cedula proporcionado.');

  readln;
end;

procedure menu(var padinfo: info; var iadinfo: info; var acadinfo: info);
var
  opcion: char;
begin
  repeat
    clrscr;
    writeln('/////Menu Principal\\\\\');
    writeln('1. Agregar informacion');
    writeln('2. Mostrar informacion');
    writeln('3. Buscar informacion');
    writeln('4. Facturar');
    writeln('0. Salir');
    writeln('--------------------------');
    write('Seleccione una opcion: ');
    opcion := ReadKey;
    writeln(opcion);
    case opcion of
      '1':begin
      agregarinfo(padinfo, iadinfo, acadinfo);
      inicarch(padinfo, iadinfo, acadinfo);
        end;
      '2':begin
        mostrarinfo(padinfo, iadinfo, acadinfo);
        inicarch(padinfo, iadinfo, acadinfo);
        end;
      '3': 
      begin

      buscarinfo(padinfo, iadinfo, acadinfo);
      inicarch(padinfo, iadinfo, acadinfo);
      end;
      '4': begin
          FacturarPorid(padinfo, iadinfo, acadinfo);
          inicarch(padinfo, iadinfo, acadinfo);
      end;
    end;
  until opcion = '0';
end;

begin
  inicarch(padinfo, iadinfo, acadinfo);
  menu(padinfo, iadinfo, acadinfo);
end.
