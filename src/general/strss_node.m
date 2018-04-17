function S = strss_node(param, connec, xx, elset, sigma)
%
%
%
% ...Parameters...
  nnode = param.nnode;
  nelem = param.nelem;
  nstrs = 3;

  S = zeros(nstrs+1,nnode);

%------- Start loop over the ielement --------------------------%
  for ielem = 1 : nelem                                         %
%---------------------------------------------------------------%

% Extract informations of i-th element from connec and xx
    [inope, lnode, ~, iset] = extra_loca(ielem, connec, xx);

% 
    eltyp = elset(iset,2);
    ngpel = elset(iset,3);

% Extrapolation functions
    extrap = extra_func(eltyp,ngpel);
    for istrs = 1 : nstrs
      for inode = 1 : inope
        for igaus = 1 : ngpel
           S(istrs,lnode(inode)) = S(istrs,lnode(inode)) + ...
                   extrap(inode,igaus)*sigma(istrs,igaus,ielem);
        end
      end
    end
    S(nstrs+1,lnode) = S(nstrs+1,lnode) + 1;
  end
%------- End loop ----------------------------------------------%

% Find mean stress at each node
  for inode = 1 : nnode
    S(1:nstrs,inode) =  S(1:nstrs,inode)/S(nstrs+1,inode);
  end
  
end