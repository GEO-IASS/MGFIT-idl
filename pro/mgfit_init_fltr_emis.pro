function mgfit_init_fltr_emis, emissionlines, wavel_min, wavel_max
;+
; NAME:
;     mgfit_init_fltr_emis
; PURPOSE:
;     initialize and filter the emission line lists from the line_data
;     within the specified wavelength range
; EXPLANATION:
;
; CALLING SEQUENCE:
;     lines_selected=mgfit_init_fltr_emis(line_data, wavel_min, wavel_max)
;
; INPUTS:
;     line_data - the emission line list read using read_stronglines(),
;          read_deeplines(), and read_ultradeeplines(),
;          line list array with the following structure
;          { Wavelength:0.0, 
;            Ion:'', 
;            Multiplet:'', 
;            LowerTerm:'', 
;            UpperTerm:'', 
;            g1:'', 
;            g2:''}
;
; RETURN:  emissionlines_select,
;          line list array with the following structure
;          { wavelength: 0.0, 
;            peak:0.0, 
;            sigma1:0.0, 
;            flux:0.0, 
;            uncertainty:0.0, 
;            redshift:0.0, 
;            resolution:0.0, 
;            blended:0, Ion:'', 
;            Multiplet:'', 
;            LowerTerm:'', 
;            UpperTerm:'', 
;            g1:'', 
;            g2:''}
;
; REVISION HISTORY:
;     IDL by A. Danehkar, 20/07/2014
;- 
  emissionlinestructure={wavelength: 0.0, peak:0.0, sigma1:0.0, flux:0.0, uncertainty:0.0, redshift:0.0, resolution:0.0, blended:0, Ion:'', Multiplet:'', LowerTerm:'', UpperTerm:'', g1:'', g2:''}

  temp=size(emissionlines,/DIMENSIONS)
  speclength=temp[0]
  linelocation01 = where(emissionlines.wavelength ge wavel_min)
  linelocation1=min(linelocation01)
  linelocation02 = where(emissionlines.wavelength le wavel_max)
  linelocation2=max(linelocation02)
  nlines = linelocation2 - linelocation1 + 1

  if nlines gt 0 then begin
    emissionlines_select=replicate(emissionlinestructure, nlines)
    emissionlines_select[0:nlines-1].wavelength=emissionlines[linelocation1:linelocation2].wavelength
    emissionlines_select[0:nlines-1].uncertainty = 0.0
    emissionlines_select[0:nlines-1].peak = 1000.0
    emissionlines_select[0:nlines-1].Ion = emissionlines[linelocation1:linelocation2].Ion
    emissionlines_select[0:nlines-1].Multiplet = emissionlines[linelocation1:linelocation2].Multiplet
    emissionlines_select[0:nlines-1].LowerTerm = emissionlines[linelocation1:linelocation2].LowerTerm
    emissionlines_select[0:nlines-1].UpperTerm = emissionlines[linelocation1:linelocation2].UpperTerm
    emissionlines_select[0:nlines-1].g1 = emissionlines[linelocation1:linelocation2].g1
    emissionlines_select[0:nlines-1].g2 = emissionlines[linelocation1:linelocation2].g2
  endif
  return, emissionlines_select
end
