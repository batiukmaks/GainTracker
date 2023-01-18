"""Added authors for exercises

Revision ID: 5efb2da87a0a
Revises: 7767183d2063
Create Date: 2023-01-14 20:56:02.321840

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = '5efb2da87a0a'
down_revision = '7767183d2063'
branch_labels = None
depends_on = None


def upgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.add_column('exercise', sa.Column('author_id', sa.Integer(), nullable=True))
    op.create_foreign_key(None, 'exercise', 'user', ['author_id'], ['id'], ondelete='CASCADE')
    # ### end Alembic commands ###


def downgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_constraint(None, 'exercise', type_='foreignkey')
    op.drop_column('exercise', 'author_id')
    # ### end Alembic commands ###