function hindi_words_gen(text_file_source,dest_loc_name,dest_label_loc,font_file_source)
%
% WORKING only for a word
% creates images of words contained in text_file_source and generates labels for it.
% text_file_source -> file containing required words
% dest_loc_name	   -> location where the words will be saved
% font_file_source -> file containing names of fonts
% dest_label_loc   -> loacation where labels are to be stored


ffd=fopen(font_file_source,'r');

while ~feof(ffd)
fonts = fgetl(ffd);
	k=0;
	
	fod=fopen(text_file_source,'r');
	directory=sprintf('%s\\',dest_loc_name);
	mkdir(directory);
	
	
while ~feof(fod)
	current_para=fgetl(fod);
	k=k+1;
	tt=current_para;
	syscmd = sprintf('convert -background white -fill black -font %s -pointsize 120 label:%s %s%s_W2#%d.pbm',fonts,tt,directory,fonts,k);
	
	label_dir=sprintf('%s\\',dest_label_loc);
	mkdir(label_dir);
	if(~system(syscmd))
		fwd=fopen(sprintf('%s%s_W2#%d.lab',label_dir,fonts,k),'w');
		fprintf(fwd,'%s',tt);
		fclose(fwd);
	end

end
fclose(fod);
end
fclose(ffd);

end
