clear all;
%%
x = randn(131,28,30) + 1j*randn(131,28,30);
level = 1;
nddwt = nd_dwt_3D('db1',size(x),1,0);
nddwt_mex = nd_dwt_3D('db1',size(x),1,1);

num_test = 1;
tic;
for ind = 1:num_test;
	y_mat = nddwt.dec(x,level);
end
t1 =toc;


tic;
for ind = 1:num_test;
	y_mex = nddwt_mex.dec(x,level);
end
t2 = toc;

display(sprintf('Forward 3D test %f percent faster, %f as fast, error %s',100*(t2-t1)/t1,t1/t2,num2str(max(abs(y_mat(:)-y_mex(:))))))

tic;
for ind = 1:num_test;
	x_mat = nddwt.rec(y_mat);
end
t3 =toc;

tic;
for ind = 1:num_test
	x_mex = nddwt_mex.rec(y_mex);
end
t4 = toc;
fprintf('\n');
display(sprintf('Backward 3D test %f percent faster, %f as fast, error %s',100*(t4-t3)/t3,t3/t4,num2str(max(abs(x_mat(:)-x_mex(:))))))
