function dataset_gen(img_files_loc,label_loc)

[Files,Bytes,Names] = Dirr(img_files_loc,'name');
    
	%disp(length(Names));
    for n = 1: length(Names)
        TXTName=Names(n);
        [pathstr, name, ext] = fileparts(TXTName{1});
        I = imread(TXTName{1});
		%I=rgb2gray(I);
		prune=10;
		
		I=im2bw(I);
		%  vectorization
		imwrite(I,'tempppppppppppp.pbm');
		m=size(I,1);
		n=size(I,2);
		command= sprintf('QAvectorizationRW -in tempppppppppppp.pbm -out temppppppppppppppppp.dxf -prune %d',prune);
		system(command);
		
		
		delete('tempppppppppppp.pbm');
		fod=fopen([label_loc '/' name '.lab'],'r');
		t=fgets(fod);
		for i=1:30			
			fwd=fopen([label_loc '/' name '_' num2str(i) '.lab'],'w');
			fprintf(fwd,'%s',t);
			fclose(fwd);
			dxf_to_dots_rand_cubic_spline('temppppppppppppppppp.dxf',m,n,sprintf('%s\\%s_%d',pathstr,name,i));
		end
		fclose(fod);
		delete(TXTName{1});
		delete([label_loc '/' name '.lab']);
		delete('temppppppppppppppppp.dxf');
	end
end
		
		
		
		