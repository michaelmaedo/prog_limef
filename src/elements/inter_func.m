function [shape, dernat] = inter_func(etype, posgp)

%%%%%%%%%%%%%%%%% INTERPOLATE SHAPE FUNCTIONS %%%%%%%%%%%%%%%%%%%
%
%  INPUT
%    etype  : Type of element
%    posgp  : Position of gauss point
%
%  OUTPUT
%    shape  : Interpolate shape functions
%    dernat : Derivatives with respect to natural coordinates
%
% ...
  switch (etype)

    case 3 % Three-Node Triangular Element
      [shape, dernat]  = tria3_shpe(posgp(1), posgp(2));

    case 5 % Four-Node Rectangular Element
      [shape, dernat] = quad4_shpe(posgp(1), posgp(2));

    otherwise % In any other case
      error('shape: Invalid element type');

  end
end