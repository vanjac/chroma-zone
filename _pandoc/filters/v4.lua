function Header(element)
  if element.level == 1 then
    return pandoc.Header(1, pandoc.Span(element.content))
  end
end
