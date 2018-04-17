function [inope, iconnec, ix, iset] = extra_loca(iel, connec, xx)
%
%%%%%% EXTRACT INFORMATION OF I-ELEMENT FROM CONNEC AND XX %%%%%%
%
%  INPUTS
%    iel     : i-element
%    connec  : global connectivity
%    xx      : global nodal coordinates
%
%  OUTPUTS
%    inope   : number of nodes of i-element
%    iconnec : connectivity of i-element
%    ix      : nodal coordinates of i-element
%    iset    : set of i-element
%
% ...

% Store the connectivity of i-element in localconnec
  localconnec = connec(iel,:);

% Ensure that localconnec contains only nonzero nodes
  localconnec = localconnec(localconnec ~= 0);

% Compute inope, iset and iconnec from localconnec
  inope   = size(localconnec(3:end),2);
  iset    = localconnec(2);
  iconnec = localconnec(3:inope+2);

% Store in ix the coordinates of i-element
  ix = zeros(inope,2);
  for localnode = 1 : inope
    gnode           = iconnec(localnode);
    ix(localnode,:) = xx(gnode,2:end);
  end

end