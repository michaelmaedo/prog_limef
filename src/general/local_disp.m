function ue = local_disp(inope, iconnec, u)
%
%%%%%%%%%%%%%% DETERMINE LOCAL NODAL DISPLACEMENTS %%%%%%%%%%%%%%
%
%  INPUT
%    inope   : Number of nodes of i-element
%    iconnec : Connectivity of i-element
%    u       : Global nodal displacements
%
%  OUTPUT
%    ue      : Local nodal displacements
%
% ...
% ... Preallocate ue...
  ue = zeros(inope,1);

% Extract nodal displacements from u and stores in ue
  for ii = 1 : inope
     inode = iconnec(ii);
     ue(2*ii-1) = u(2*inode-1);
     ue(2*ii)   = u(2*inode);
  end

end