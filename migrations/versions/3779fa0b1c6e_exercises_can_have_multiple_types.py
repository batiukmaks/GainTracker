"""exercises can have multiple types

Revision ID: 3779fa0b1c6e
Revises: 96b1262f2594
Create Date: 2022-12-15 19:36:34.628466

"""
from alembic import op
import sqlalchemy as sa
from sqlalchemy.dialects import mysql

# revision identifiers, used by Alembic.
revision = '3779fa0b1c6e'
down_revision = '96b1262f2594'
branch_labels = None
depends_on = None


def upgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_constraint('exercise_ibfk_1', 'exercise', type_='foreignkey')
    op.drop_column('exercise', 'type_id')
    op.add_column('exercise_type', sa.Column('exercise_id', sa.Integer(), nullable=True))
    op.add_column('exercise_type', sa.Column('exercise_type', sa.String(length=255), nullable=True))
    op.create_foreign_key(None, 'exercise_type', 'exercise', ['exercise_id'], ['id'], ondelete='CASCADE')
    op.drop_column('exercise_type', 'name')
    # ### end Alembic commands ###


def downgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.add_column('exercise_type', sa.Column('name', mysql.VARCHAR(length=255), nullable=True))
    op.drop_constraint(None, 'exercise_type', type_='foreignkey')
    op.drop_column('exercise_type', 'exercise_type')
    op.drop_column('exercise_type', 'exercise_id')
    op.add_column('exercise', sa.Column('type_id', mysql.INTEGER(), autoincrement=False, nullable=True))
    op.create_foreign_key('exercise_ibfk_1', 'exercise', 'exercise_type', ['type_id'], ['id'], ondelete='CASCADE')
    # ### end Alembic commands ###