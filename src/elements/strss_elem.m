function [sigma] = strss_elem(hypth, inope, ix, idof, localset,...
                              nstrs, ue)
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
%    ue       : Local displacements
%
%  OUTPUT
%    sigma    : Stresses in the element
%
% ...
% ...Recover set properties...
  model = localset(1);
  itype = localset(2);
  ngpel = localset(3);
  prop  = localset(4:end);
  
% ...Initialize Se matrix...
  sigma    = zeros(nstrs,ngpel);

% Compute the position of the gauss point and its weight
  [posgp, ~] = gauss_quad(itype, ngpel);

%------- Start loop over gauss point ---------------------------%
  for igaus = 1 : ngpel                                         %
%---------------------------------------------------------------%

% Interpolate (shape) functions
    [shape, dernat] = inter_func(itype, posgp(:,igaus));

% Coordinate of gauss point
    [xx_gausp] = coord_gaus(shape, ix);

% Construct J-matrix and find its inverse and its determinant
    [~, invJ] = jacob_matx(dernat, ix);

% Kinematics relation
    [B] = bmatx_proc(   hypth, inope,  idof,  shape,  dernat, ...
                     xx_gausp, invJ);

% Determine the constitutive matrix and the thickness
    [C, ~] = const_matx(hypth, model, prop, xx_gausp);

% Compute stresses at the gauss point
    sigma(:,igaus) = C*B*ue;

  end
%------- end loop ----------------------------------------------%

end