{{page.url}}
{{page.url | remove_first: "/"}}
{{page.url | remove_first: "/" | split: "/"}}
{{page.url | remove_first: "/" | split: "/" | first}}
