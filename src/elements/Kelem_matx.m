function [Ke, Fe] = Kelem_matx(hypth, inope, ix, idof, localset)
%
%%%%%%%%%%%%%%%% COMPUTE K-MATRIX OF THE ELEMENT %%%%%%%%%%%%%%%%
%
%  INPUT
%    hypth    : Hypothesis assumed (Plane Stress, Plane Strain, etc)
%    inope    : Number of nodes of i-th element
%    iconnec  : Connectivity of i-th element
%    ix       : Nodal coordinates of i-th element
%    idof     : Degrees of freedom of i-th element
%    localset : Element's Type and Material Properties of i-th elem
%
%  OUTPUT
%    Ke       : K matrix of i-th element
%    Fe       : F of i-th element
%
% ...
% ...Recover set properties...
  model = localset(1);
  itype = localset(2);
  ngpel = localset(3);
  prop  = localset(4:end);
  
% ...Initialize Ke matrix...
  Ke = zeros(idof,idof);
  f  = zeros(1,inope);

% Compute the position of the gauss point and its weight
  [posgp, W] = gauss_quad(itype, ngpel);

%------- Start loop over gauss point ---------------------------%
  for igaus = 1 : ngpel                                         %
%---------------------------------------------------------------%

% Interpolate (shape) functions
    [shape, dernat] = inter_func(itype, posgp(:,igaus));

% Coordinate of gauss point
    [xx_gausp] = coord_gaus(shape, ix);

% Construct J-matrix and find its inverse and its determinant
    [detJ, invJ] = jacob_matx(dernat, ix);

% Kinematics relation and thickness
    [B] = bmatx_proc(   hypth, inope,  idof,  shape,  dernat, ...
                     xx_gausp, invJ);

% Determine the constitutive matrix
    [C, t] = const_matx(hypth, model, prop, xx_gausp);

% Compute K-matrix of the element
    Ke = Ke + B'*C*B*W(igaus)*t*detJ;
    
% Compute f of the element
    f  = f + shape*prop(4)*W(igaus)*t*detJ;
  end
%------- end loop ----------------------------------------------%

% Assemble Fe
  Fe = zeros(idof,1);
  for ino = 1 : inope
      Fe(2*ino) = -f(ino);
  end

end