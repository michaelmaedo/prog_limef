function res2gid(file, param, connec, xx, u, R, S)
%
%%%%%%%%%%%%%% CONVERT COMPUTED RESULTS TO GID %%%%%%%%%%%%%%%%%%
%
%  INPUT
%    file   : Name of the file
%    param  : Control Parameters such as: nnode, nelem, etc.
%    connec : Global Connectivity of the System
%    xx     : Global Coordinates of the System
%    u      : Nodal displacements
%    R      : Reaction on the fixed nodes
%
% ...
% ...Parameters...
  hypth = param.hypth;
  nnode = param.nnode;
  nnope = param.nnope;
  nelem = param.nelem;
  nnope = param.nnope;

  folder = strcat('~/LIFE/',file);
  if ~exist(folder,'dir')
    status = mkdir(folder);
  end
  
  if (nnope == 3)
    eletyp = 'Triangle';
  else
    eletyp = 'Quadrilateral';
  end

  msh_file = strcat(folder,'/',file,'.flavia.msh');
  res_file = strcat(folder,'/',file,'.flavia.res');
  
  fid = fopen(msh_file,'w');
  fprintf(fid,'### \n');
  fprintf(fid,'# N L I F E Program  V 1.0 \n');
  fprintf(fid,'# \n');
  fprintf(fid,['MESH dimension %3.0f  Elemtype %s  Nnode %2.0f \n \n'], ...
          2, eletyp, nnope);
  fprintf(fid,['coordinates \n']);
  for inode = 1 : nnode
    fprintf(fid,['%6.0f %12.5e %12.5e \n'], xx(inode,:));
  end
  fprintf(fid,['end coordinates \n \n']);
  fprintf(fid,['elements \n']);
  if (nnope == 3)
    for i = 1 : nelem
      fprintf(fid,['%6.0f  %6.0f  %6.0f  %6.0f  %6.0f \n'],   ...
              connec(i,1), connec(i,3:5), connec(i,2));
    end
  else  
    for i = 1 : nelem
      fprintf(fid,['%6.0f %6.0f %6.0f %6.0f %6.0f %6.0f \n'], ...
              connec(i,1), connec(i,3:6), connec(i,2));
    end
  end 
  fprintf(fid,['end elements \n \n']);
  status = fclose(fid);

  fid = fopen(res_file,'w');
  fprintf(fid,'Gid Post Results File 1.0 \n');
  fprintf(fid,'### \n');
  fprintf(fid,'# N L I F E Program  V.1.0 \n');
  fprintf(fid,'# \n');
  fprintf(fid,['Result "Displacements" "Load Analysis"  1  Vector OnNodes \n']);
  fprintf(fid,['ComponentNames "X-Displ", "Y-Displ", "Z-Displ" \n']);
  fprintf(fid,['Values \n']);
  for i = 1 : nnode
    fprintf(fid,['%6.0i %12.5e %12.5e \n'], i, u(i*2-1), u(i*2));
  end
  fprintf(fid,['End Values \n']);
  fprintf(fid,'# \n');
  fprintf(fid,['Result "Reaction" "Load Analysis"  1  Vector OnNodes \n']);
  fprintf(fid,['ComponentNames "Rx", "Ry", "Rz" \n']);
  fprintf(fid,['Values \n']);
  for i = 1 : nnode
    fprintf(fid,['%6.0f %12.5e %12.5e \n'],i,R(i*2-1),R(i*2));
  end
  fprintf(fid,['End Values \n']);
  fprintf(fid,'# \n');
  fprintf(fid,['Result "Stresses" "Load Analysis"  1  Matrix OnNodes \n']);
  fprintf(fid,['ComponentNames "Sx", "Sy", "Sz", "Sxy", "Syz", "Sxz" \n']);
  fprintf(fid,['Values \n']);
  switch(hypth)
      case 1 % Plane Stress
        for i = 1 : nnode
          fprintf(fid,['%6.0f %12.5d %12.5d  0.0 %12.5d 0.0  0.0 \n'], i, S(1,i), S(2,i), S(3,i));
        end
      case 2 % Plane Strain
          for i = 1 : nnode
              fprintf(fid,['%6.0f %12.5d %12.5d %12.5d %12.5d' ...
                           '0.0  0.0 \n'], i, S(:,i));
          end
      case 3 % Axisymmetric
          for i = 1 : nnode
              fprintf(fid,['%6.0f %12.5d %12.5d %12.5d %12.5d' ...
                           '0.0  0.0 \n'], i, S(:,i));
          end
  end
  fprintf(fid,['End Values \n']);
  status = fclose(fid);
  
end