function extrap = quad4_extr(ngpel)

%%%%%%%%%%%% EXTRAP: FOUR-NODE RECTANGULAR ELEMENT %%%%%%%%%%%%%%
%
%  OUTPUT
%    extrap : Extrapolate  to the nodes  the stresses  from gauss
%             points
%
% ...
% ...Parameters...
    a = 1.00000000000D+00;
    b = 1.86602540378D+00;
    c = -0.5000000000D+00;
    d = 1.33974596216D-01;

%------- 1 Gauss Point -----------------------------------------%
    if (ngpel == 1)                                             %
%---------------------------------------------------------------%
        extrap(1,1) = a;
        extrap(2,1) = a;
        extrap(3,1) = a;
        extrap(4,1) = a;

%------- 4 Gauss Point -----------------------------------------%
    elseif (ngpel == 4)                                         %
%---------------------------------------------------------------%
        extrap(1,1) = b;
        extrap(1,2) = c;
        extrap(1,3) = c;
        extrap(1,4) = d;
        extrap(2,1) = c;
        extrap(2,2) = d;
        extrap(2,3) = b;
        extrap(2,4) = c;
        extrap(3,1) = d;
        extrap(3,2) = c;
        extrap(3,3) = c;
        extrap(3,4) = b;
        extrap(4,1) = c;
        extrap(4,2) = b;
        extrap(4,3) = d;
        extrap(4,4) = c;

%------- Any other case ----------------------------------------%
    else                                                        %
%---------------------------------------------------------------%
        error('quad4_ext: Invalid number of gauss point');

    end
end