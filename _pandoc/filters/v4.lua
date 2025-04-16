local title

function Header(el)
  if el.level == 1 then
    if not title then
      title = pandoc.utils.stringify(el.content)
    end
    return pandoc.Header(1, pandoc.Span(el.content))
  end
end

function Meta(el)
  if title and not el.title then
    print("Detected title: " .. title)
    el.title = title
    return el
  end
end
