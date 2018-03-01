import React from "react";

require("prismjs/themes/prism-solarizedlight.css");

export default ({ data }) => {
    const post = data.markdownRemark;
    console.log(post);
    return (
        <div>
            <h1>{post.frontmatter.title}</h1>
            <h5>Last updated: {post.frontmatter.date}</h5>
            <div dangerouslySetInnerHTML={{ __html: post.html }} />
        </div>
    );
};

export const query = graphql`
  query BlogPostQuery($slug: String!) {
    markdownRemark(fields: { slug: { eq: $slug } }) {
      html
      frontmatter {
        title
        date
        publish
      }
    }
  }
`;