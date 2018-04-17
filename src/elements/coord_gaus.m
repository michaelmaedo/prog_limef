function [xx_gausp] = coord_gaus(shape, ix)
%
%%%%%%%%%%%%%%%%% COORDINATE OF GAUSS POINT %%%%%%%%%%%%%%%%%%%%%
%
%  INPUT
%    shape    : Interpolate shape functions
%    ix       : Nodal coordinates of i-element
%
%  OUTPUT
%    xx_gausp : Coordinates of gauss point in the physical domain
%
  xx_gausp(1) = shape*ix(:,1);
  xx_gausp(2) = shape*ix(:,2);
end