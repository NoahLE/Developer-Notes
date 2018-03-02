import React from "react";

export default ({data}) => (
    <div>
        <h1>Why does {data.site.siteMetadata.title} exist?</h1>
        <p>
            This is a website for hosting useful notes, code snippets, and other ideas. The source code
            lives <a href="https://github.com/NoahLE/Dev-Notes">here</a> so feel free to make contributions as pull requests!
        </p>
    </div>
);

export const query = graphql`
    query AboutQuery {
        site {
            siteMetadata {
                title
            }
        }
    }
`