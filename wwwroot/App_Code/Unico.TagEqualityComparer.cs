using System.Collections.Generic;

using umbraco.NodeFactory;
using umbraco.cms.businesslogic.Tags;

namespace Unico
{
    public class TagEqualityComparer : IEqualityComparer<Tag>
    {

        public bool Equals(Tag tag1, Tag tag2)
        {
            if (tag1.Id == tag2.Id)
            {
                return true;
            }
            else
            {
                return false;
            }
        }


        public int GetHashCode(Tag tag)
        {
            return tag.Id;
        }

    }
}