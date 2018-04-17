function [detJ, invJ] = jacob_matx(dernat, ix)
%
%%% CONSTRUCT JACOBIAN MATRIX AND FIND ITS DET. AND ITS INV. %%%%
%
%  INPUT
%    dernat : Derivatives with respect natural coordinates
%    ix     : Nodal coordinates of i-element
%
%  OUTPUT
%    J    : Jacobian matrix
%    detJ : Determinand of J
%    invJ : Inverse of J
%
% ...

% Jacobian matrix
  J = dernat*ix;

% Determinant and inverse of J
  detJ = det(J);
  invJ = inv(J);

end