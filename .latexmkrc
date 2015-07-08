$pdf_previewer = 'osascript -e "set theFile to POSIX file \"%S\" as alias" -e "set thePath to POSIX path of theFile" -e "tell application \"Skim\"" -e "open theFile" -e "end tell"';
$pdf_update_method = 4;
$pdf_update_command = '/usr/bin/osascript -e "set theFile to POSIX file \"%S\" as alias" -e "set thePath to POSIX path of theFile" -e "tell application \"Skim\"" -e  "  set theDocs to get documents whose path is thePath" -e "  try" -e "    if (count of theDocs) > 0 then revert theDocs" -e "  end try" -e "  open theFile" -e "end tell"';

add_cus_dep('gnuplot','tex', 0, 'makegnu2tex');
sub makegnu2tex {
    system("gnuplot \"$_[0].gnuplot\"") ;
}

@default_files = ("*.Rnw");
$pdf_mode = 1;
$graphicx_opts = "final";
$color_opts = "usenames,dvipsnames";
$pdflatex = '([[ ! "%T" =~ \\.Rnw$ ]] || Rscript -e "'.
 			'library(knitr);' .
 			'opts_knit\$set(latex.options.graphicx = \"' .
 				$graphicx_opts .
 				'\", latex.options.color = \"' .
 				$color_opts .
 				'\", concordance = TRUE); ' .
 			'knit(\'%B.Rnw\');" ' .
 		') && pdflatex -shell-escape %O %B ' .
 		'&& ([[ ! "%T" =~ \\.Rnw$ ]] || Rscript -e "' .
 			'library(patchSynctex); ' .
 			'patchSynctex(\'%B\', verbose = TRUE);")'
 		;
