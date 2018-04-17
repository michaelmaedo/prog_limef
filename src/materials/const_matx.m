function [C, t] = const_matx(hypth, model, prop, xx_gausp)
%
%%%%%%%%%%%%%%%%%%%%%% CONSTITUTIVE MATRIX %%%%%%%%%%%%%%%%%%%%%%
%
%  INPUT
%    hypth    : Hypothesis (Plane Stress, Plane Strain, etc.)
%    model    : Define the behavior of the material
%    prop     : Material Properties
%    xx_gausp : Coordinates of gauss point
%
%  OUTPUT
%    C        : Constitutive Matrix
%    t        : Thickness
%
% ...
% ...

  switch (model)
%
%------- Linear Elastic Material -------------------------------%
    case 0                                                      %
%---------------------------------------------------------------%
%
%  prop(1) = E: young modulus
%  prop(2) = v: Poisson's ratio
%  prop(3) = thickness
%
     [C, t] = linea_elas(hypth, prop(1), prop(2), prop(3),...
                             xx_gausp);


%------- In any other case -------------------------------------%
    otherwise                                                   %
%---------------------------------------------------------------%
      error('const_matx: invalid constitutive model');
  end

end