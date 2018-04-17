function [Fext] = natur_boun(hypth, xx, localset, load, F)

%%%%%%%%%%%%%%% VECTOR OF EXTERNAL NODAL FORCES %%%%%%%%%%%%%%%%%
%
%  INPUTS
%    hypth    : Hypothesis assumed (Plane Stress or Axisym, etc.)
%    xx       : Global nodal coordinates
%    localset : Element's Type and Material Properties
%    load     : External loads applied
%    F        : Global external loads
%
%  OUTPUT
%    Fext  : External nodal forces
%
% ...
% ...Recover Fext...
  t    = localset(6);
  Fext = F;

% ...Add point loads to Fext...
  for iload = 1 : size(load.point,1)
    ino = load.point(iload,1);
    Fext(2*ino-1) = Fext(2*ino-1) + load.point(iload,2);
    Fext(2*ino)   = Fext(2*ino)   + load.point(iload,3);
  end

% ...Add face loads to Fext...
  switch hypth

%------- Plane stress ------------------------------------------%
    case 1                                                      %
%---------------------------------------------------------------%

% Loop over the faces loaded
      for iload = 1 : size(load.face,1)

% Store in ino the number of the node 
        ino  = [load.face(iload,1), load.face(iload,2)];

% lface contains the load faces
        lface = [load.face(iload,3), load.face(iload,4) ;
                load.face(iload,5), load.face(iload,6)];
          
% Nodal coordinates of the loaded face
        xface = xx(ino(1),:) - xx(ino(2),:);

% Length of the face
        len   = sqrt(sum(xface(2:end).^2));

% Number of the 1st node associated to the loaded face 
        Fext(2*ino(1)-1) = Fext(2*ino(1)-1) + t*lface(1,1)*len/2;
        Fext(2*ino(1))   = Fext(2*ino(1))   + t*lface(1,2)*len/2;

% Number of the 2nd node associated to the loaded face
        Fext(2*ino(2)-1) = Fext(2*ino(2)-1) + t*lface(2,1)*len/2;
        Fext(2*ino(2))   = Fext(2*ino(2))   + t*lface(2,2)*len/2;
      end

%------- Plane stress ------------------------------------------%
    case 2                                                      %
%---------------------------------------------------------------%

% Loop over the faces loaded
      for iload = 1 : size(load.face,1)

% Store in ino the number of the node 
        ino  = [load.face(iload,1), load.face(iload,2)];

% lface contains the load faces
        lface = [load.face(iload,3), load.face(iload,4) ;
                load.face(iload,5), load.face(iload,6)];
          
% Nodal coordinates of the loaded face
        xface = xx(ino(1),:) - xx(ino(2),:);

% Length of the face
        len   = sqrt(sum(xface(2:end).^2));

% Number of the 1st node associated to the loaded face 
        Fext(2*ino(1)-1) = Fext(2*ino(1)-1) + lface(1,1)*len/2;
        Fext(2*ino(1))   = Fext(2*ino(1))   + lface(1,2)*len/2;

% Number of the 2nd node associated to the loaded face
        Fext(2*ino(2)-1) = Fext(2*ino(2)-1) + lface(2,1)*len/2;
        Fext(2*ino(2))   = Fext(2*ino(2))   + lface(2,2)*len/2;
      end
      
%------- In any other case -------------------------------------%
    otherwise                                                   %
%---------------------------------------------------------------%
      error('natur_boun: invalid hypth');
  end
end