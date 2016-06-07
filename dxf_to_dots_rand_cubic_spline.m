
function dxf_to_dots_rand_cubic_spline(dxf_source,m,n,img_name)
%
%
%
%
%

mat = zeros(m,n);
matx = zeros(m);
maty = zeros(n);
%open file to read
rng('shuffle');
fod=fopen(dxf_source);
k = 0;
flag=1;
xy=[];ya=[];xa=[];
		
while ~feof(fod)
    curr = fgets(fod);
    k = strfind(curr, 'VERTEX');
	if(strfind(curr, 'SEQEND')) 
		flag=0;
	end
	
	if k
		fgets(fod);
		y=str2num(fgets(fod));
		
		if maty(y) ~=0
			y=maty(y);
		else 
			maty(y)=y+(rand*15);
			y=maty(y);
		end
		
		ya=[ya y];
		fgets(fod);
		x=str2num(fgets(fod));
		
		if matx(x) ~=0
			x=matx(x);
		else 
			matx(x)=x+(rand*15);
			x=matx(x);
        end
		
        xa=[xa x];
	end
		
	if flag==0
            xy=[xa;ya];
			xy1=cscvn(xy);
			
			mm=fnplt(xy1);
			mm=ceil(mm);
			bs=size(mm,2);
			for j = 1:bs-1
				if (mm(1,j)<1) || (mm(2,j)<1) || (mm(1,j+1)<1) || (mm(2,j+1)<1)
					continue
				end
                if (mm(1,j))==(mm(1,j+1)) && (mm(2,j))==(mm(2,j+1)) 
					continue 
				end
				[m,n]=bresenham((mm(1,j)),(mm(2,j)),(mm(1,j+1)),(mm(2,j+1)));
				l=size(m,1);
				for kk = 1:l
					mat(m(kk),n(kk))=1;
				end
			end
			
			
			
            xa=[];ya=[];xy=[];
			flag=1;
		end
		
		%mat(x,y)=1;
		
	

	
	end



mat=bwmorph(mat,'dilate');

mat=mat~=1;
H = fspecial('average', [5 5]);
mat = imfilter(mat, H);

imwrite(mat,sprintf('%s.pbm',img_name));

fclose(fod);
end