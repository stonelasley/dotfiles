local present, orgmode = pcall(require, "orgmode")

if present then 
  orgmode.setup_ts_grammar()
  orgmode.setup{
    org_agenda_files = '~/Projects/st1/notebook/*' ,
    org_default_notes_file = '~/Projects/st1/notebook/refile.org',
  }
end
