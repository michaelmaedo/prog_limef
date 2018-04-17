function [shape, dernat] = tria3_shpe(r, s)
%
%%%%%%%%%%%%%%%%% THREE-NODE TRIANGULAR ELEMENT %%%%%%%%%%%%%%%%%
%
%                s
%                |
%            (3) o                         Node    (r,s)
%                | \                       ----    -----
%                |   \                       1     (0,0)
%                |     \                     2     (1,0)
%                |       \                   3     (0,1)
%                |         \
%                |           \
%                |             \ (2)
%            (1) o---------------o --- r
%
%  INPUT
%    r      : 1st local coord of gauss point in the parent domain
%    s      : 2nd local coord of gauss point in the parent domain
%
%  OUTPUT
%    shape  : Interpolate shape functions
%    dernat : Derivatives with respect to natural coordinates
%
% ...
% Shape functions
  shape(1) = 1.0000D+00 - r - s;
  shape(2) = r;
  shape(3) = s;

% Derivaties with respect to natural coordinates
  dernat(1,1) = -1.0000D+00;
  dernat(1,2) =  1.0000D+00;
  dernat(1,3) =  0.0000D+00;
  dernat(2,1) = -1.0000D+00;
  dernat(2,2) =  0.0000D+00;
  dernat(2,3) =  1.0000D+00;

end
