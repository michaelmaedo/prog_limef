function extrap = extra_func(eltyp,ngpel)

%%%%%%%%%%%%%%%%%%% DIRECT LOCAL EXTRAPOLATION %%%%%%%%%%%%%%%%%%
%
%  INPUT
%    eltyp  : Type of element
%    ngpel  : Number of gauss point 
%
%  OUTPUT
%    extrap : These functions extrapolate to the nodes the stresses
%             in the gauss points
%
% ...
    switch(eltyp)
        
        case 3 % Three-Node Triangular Element
            extrap = tria3_extr();
            
        case 5 % Four-Node Rectangular Element
            extrap = quad4_extr(ngpel);
            
        otherwise % In any other case
            error('extrap: Invalid type of element');
    end
end