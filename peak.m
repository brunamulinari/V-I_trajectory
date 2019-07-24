function mi = peak(partA , partB, bppoints, Wr, Wt)

% peak - Peak of middle segment:
% Find the highest peak in middle segment. It is our interpretation of the 
% formulation presented in: A. L. Wang, B. X. Chen, C. G. Wang, and D. D. Hua, 
% "Non-intrusive load monitoring algorithm based on features of V–I trajectory" 
% Electric Power Systems Research,2018
%
% IN:
% partA is the part A of V-I trajectory* 
% partB is the part A of V-I trajectory* 
% bppoints are the bending points of V-I trajectory**
% Wr is middle segment in part A***
% Wt is middle segment in part B***
%
% *To obtain the parts(A and B) use the function "parts_division"
% **To obtain the bending points use the function "bp"
% ***To obtain the middle segment in parts use the function "middleseg"
%
% OUT:
% mi is the highest peak in middle segment.
%
% If you use this function cite " A New Set of Steady-State and Transient
% Features for Power Signature Analysis Based on V-I Trajectory". Accepted 
% in: IEEE PES Innovative Smart Grid Technology Latin America, 2019.
%
%   Author: Bruna Machado Mulinari
%   Version: 1.0, 16 April 2019
%

% The bending points and the points which has the closest voltage
a1 = bppoints(1);   % part A
a2 = bppoints(2);   % part B
b1 = bppoints(3);   % part B
b2 = bppoints(4);   % part A

% Calculates angular coefficients
xa1 = partA(a1,1);
ya1 = partA(a1,2);

xa2 = partA(a2,1);
ya2 = partA(a2,2);

xb1 = partB(b1,1);
yb1 = partB(b1,2);

xb2 = partB(b2,1);
yb2 = partB(b2,2);

% Angular coefficient of fa(x)
mfa = (ya1 - yb2)/(xa1 - xb2);
% Angular coefficient of fa(x)
bfa = yb2 - mfa*xb2;

% Angular coefficient of fb(x)
mfb = (ya2 - yb1)/(xa2 - xb1);
% Angular coefficient of fb(x)
bfb = yb1 - mfb*xb1;

% Calculates the maximum distance between fa(x) and Wr, and fb(x) and Wt
fa = mfa*Wr(:,1) + bfa;
maxr = max(Wr(:,2) - (fa));
fb = mfb*Wt(:,1) + bfb;
maxt = max(Wt(:,2) - (fb));

% The highest peak in middle segment
mi = max(maxr, maxt);

end